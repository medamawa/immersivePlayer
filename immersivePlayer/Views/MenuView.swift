//
//  MenuView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import SwiftUI
import RealityKit

struct MenuView: View {
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow

    @Bindable var appModel: AppModel

    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton(appModel: appModel)


            Toggle("Audio Player", systemImage: "slider.vertical.3", isOn: $appModel.isPresentingPlayerView)
                .toggleStyle(.button)
                .onChange(of: appModel.isPresentingPlayerView) {
                    if appModel.isPresentingPlayerView {
                        openWindow(id: "AudioPlayer")
                    } else {
                        dismissWindow(id: "AudioPlayer")
                    }
                }
        }
    }
}

#Preview(windowStyle: .automatic) {
    MenuView(appModel: AppModel())
}
