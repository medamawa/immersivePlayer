//
//  immersivePlayerApp.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI

@main
struct immersivePlayerApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }

        ImmersiveSpace(id: appModel.immersivePlayerSpaceID) {
            ImmersivePlayerSpace()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.progressive), in: .progressive, .full)
    }
}
