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
                    }),
                       in: 0...player.totalDuration
                )
                .frame(width: 1000)
                .padding()


                // 再生時間の表示
                Text("\(formatTime(player.currentTime)) / \(formatTime(player.totalDuration))")
                    .font(.headline)

                ZStack {
                    HStack {
                        Spacer()

                        HStack {
                            Image(systemName: "backward.end.alt.fill")
                            
                            Button {
                                if player.isPlaying {
                                    player.pause()
                                    appModel.audioPlayerState = .paused
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

                            Image(systemName: "forward.end.alt.fill")
                        }
                        .padding()
                        .glassBackgroundEffect()

                        Spacer()
                    }


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
