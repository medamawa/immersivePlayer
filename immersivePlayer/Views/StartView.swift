//
//  StartView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/19.
//

import SwiftUI
import RealityKit

struct StartView: View {
    @Environment(\.openWindow) var openWindow
    @Environment(\.pushWindow) var pushWindow
    @Environment(\.dismissWindow) var dismissWindow

    @Bindable var appModel: AppModel

    var body: some View {
        VStack {
            VStack {
                appDescription
            }
            .padding(20)

            Button {
                appModel.wantsToPresentImmersiveSpace.toggle()
                if appModel.wantsToPresentImmersiveSpace {
                    pushWindow(id: "AudioPlayer")
                }
            } label: {
                Text(appModel.wantsToPresentImmersiveSpace ? "Close Player" : "Start Player")
                    .font(.largeTitle)
                    .frame(width: 200, height: 100)
            }
            .buttonBorderShape(.roundedRectangle(radius: 36))
            .disabled(appModel.immersiveSpaceState == .inTransition)
        }
        .padding(30)
    }

    var appDescription: some View {
        VStack {
            Text("Immersive Player")
                .font(.extraLargeTitle)

            VStack(alignment: .leading) {
                Text("🎵 Play your favorite music")
                    .font(.title)
                Text("\t- Enjoy your favorite tracks anytime, anywhere.")

                Text("🔊 3D sound")
                    .font(.title)
                    .padding(.top, 10)
                Text("\t- Feel like real speakers are right in front of you.")

                Text("✨ Dynamic decorations")
                    .font(.title)
                    .padding(.top, 10)
                Text("\t- Enhance the atmosphere and elevate your experience.")
            }
            .padding(.top, 5)
            .padding(.bottom, 10)

            Text("Let's immerse yourself in the music! 🎶")
                .font(.largeTitle)
                .padding(.bottom, 10)
        }
    }
}

#Preview(windowStyle: .automatic) {
    StartView(appModel: AppModel())
}
