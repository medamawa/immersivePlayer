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
    @StateObject private var player = PlayerViewModel()

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
                switch result {
                case .success(let urls):
                    if let fileURL = urls.first {
                        player.loadAudio(from: fileURL)
                        appModel.isAudioFileAvailable = true
                    }
                case .failure(let error):
                    print("failed: \(error.localizedDescription)")
                    appModel.isAudioFileAvailable = false
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
                                } else {
                                    player.play()
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
                }
            }

        }
        .padding()

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
