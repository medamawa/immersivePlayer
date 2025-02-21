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
    @Environment(\.dismissWindow) var dismissWindow

    @Bindable var appModel: AppModel

    var body: some View {
        VStack {
            Button {
                appModel.wantsToPresentImmersiveSpace.toggle()
            } label: {
                Text(appModel.wantsToPresentImmersiveSpace ? "Close Player" : "Start Player")
                    .frame(width: 200, height: 100)
            }
            .disabled(appModel.immersiveSpaceState == .inTransition)
        }
    }
}

#Preview(windowStyle: .automatic) {
    StartView(appModel: AppModel())
}
