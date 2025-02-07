//
//  PlayerView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import SwiftUI

struct PlayerView: View {
    @Bindable var appModel: AppModel

    @State private var isPickerPresented = false
    @State private var previousState: AudioPlayerState?
    @StateObject private var player = AudioPlayer()

    var body: some View {

        VStack {
            // audioファイルインポートボタン
            Button("import audio file") {
                isPickerPresented.toggle()
            }
            .fileImporter(
                isPresented: $isPickerPresented,
                allowedContentTypes: [.audio],
                allowsMultipleSelection: false
            ) { result in
                Task{
                    switch result {
                    case .success(let urls):
                        if let fileURL = urls.first {
                            player.loadAudio(from: fileURL)
                            appModel.audioFileURL = fileURL
                            appModel.isAudioFileAvailable = true

                            // When immersiveView open, AVFoundation player should be muted
                            switch appModel.immersiveSpaceState {
                            case .open:
                                print("muted")
                                player.mute()
                            case .closed:
                                print("unmuted")
                                player.unmute()
                            case .inTransition:
                                break
                            }
                        }
                    case .failure(let error):
                        print("failed: \(error.localizedDescription)")
                        appModel.audioFileURL = nil
                        appModel.isAudioFileAvailable = false
                    }
                }
            }

            VStack {
                // 再生位置のスライダー
                Slider(value: Binding(
                    get: { player.currentTime },
                    set: { newValue in
                        player.seek(to: newValue)
                        appModel.currentTime = newValue
                    }),
                       in: 0...player.totalDuration,
                       onEditingChanged: { isEditing in
                    if isEditing {
                        previousState = appModel.audioPlayerState
                        appModel.audioPlayerState = .seek
                    } else {
                        appModel.audioPlayerState = previousState ?? .paused
                    }
                }
                )
                .frame(width: 1000)
                .padding()


                // 再生時間の表示
                Text("\(formatTime(player.currentTime)) / \(formatTime(player.totalDuration))")
                    .font(.headline)

                ZStack {
                    HStack() {
                        Image(systemName: "10.arrow.trianglehead.counterclockwise")

                        Button {
                            if player.isPlaying {
                                player.pause()
                                appModel.audioPlayerState = .paused
                                appModel.currentTime = player.currentTime
                            } else {
                                player.play()
                                appModel.audioPlayerState = .playing
                            }
                        } label: {
                            if player.isPlaying {
                                Image(systemName: "pause.fill")
                            } else {
                                Image(systemName: "play.fill")
                            }
                        }
                        .disabled(appModel.isAudioFileAvailable == false)
                        .frame(height: 30)
                        .padding(10)

                        Image(systemName: "10.arrow.trianglehead.clockwise")
                    }
                    .frame(width: 300)
                    .padding()

                    HStack{
                        Spacer()

                        Button {
                            if appModel.playerMode == .music {
                                appModel.playerMode = .radio
                            } else {
                                appModel.playerMode = .music
                            }
                        } label: {
                            if appModel.playerMode == .music {
                                Image(systemName: "hifispeaker")
                            } else {
                                Image(systemName: "radio")
                            }
                        }
                        .padding()
                    }
                    .frame(width: 1000)


                    if appModel.immersiveSpaceState == .open &&
                        appModel.isAudioFileAvailable == false &&
                        appModel.audioFileURL != nil {
                        LoadingView()
                            .transition(.opacity)
                            .zIndex(1)
                    }
                }
            }

        }
        .padding()
        .animation(.easeInOut, value: appModel.isAudioFileAvailable)
        .onChange(of: appModel.immersiveSpaceState, initial: true) {
            // When immersiveView open, AVFoundation player should be muted
            switch appModel.immersiveSpaceState {
            case .open:
                print("muted")
                player.mute()
            case .closed:
                print("unmuted")
                player.unmute()
            case .inTransition:
                break
            }
        }
        .onChange(of: player.isPlaying) { isPlaying in
            appModel.audioPlayerState = isPlaying ? .playing : .paused
        }

    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    PlayerView(appModel: AppModel())
}
