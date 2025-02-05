//
//  ImmersiveView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import SwiftUI
import RealityKit
import ARKit

@MainActor
struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel

    @State private var viewModel = ImmersiveViewModel()
    @State private var audio = AudioStorage()

    var body: some View {
        RealityView { content in
            content.add(viewModel.rootEntity)
        }
        .onChange(of: appModel.playerMode, initial: true) { old, new in
            Task {
                appModel.isTransitioningBetweenPlayerMode = true
                try await viewModel.transitionPlayerMode(from: old, to: new)
                appModel.isTransitioningBetweenPlayerMode = false
            }
        }
        .onChange(of: appModel.audioFileURL, initial: true) {
            print("URL changed")
            Task {
                try await Task.sleep(for: .seconds(1))  // wait for speaker to be loaded
                guard let speakerEntity = viewModel.speakerEntity else { print("speaker not found"); return }
                guard let url = appModel.audioFileURL else { print("audio file not found"); return }
                print("loading audio")
                appModel.isAudioFileAvailable = false
                try await audio.prepareAudio(for: speakerEntity, with: url)
                appModel.isAudioFileAvailable = true
                print("loaded audio")
                switch appModel.audioPlayerState {
                case .playing:
                    audio.play()
                case .paused:
                    audio.pause()
                case .stopped:
                    audio.stop()
                case .seek:
                    return
                }
            }
        }
        .onChange(of: appModel.audioPlayerState, initial: true) {
            switch appModel.audioPlayerState {
            case .playing:
                audio.play()
            case .paused:
                audio.pause()
            case .stopped:
                audio.stop()
            case .seek:
                return
            }
        }
    }
}
