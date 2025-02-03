//
//  ImmersivePlayerApp.swift
//  ImmersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI

@main
struct ImmersivePlayerApp: App {
    @State var appModel = AppModel()

    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some Scene {
        Group {
            WindowGroup {
                ContentView(appModel: appModel)
                    .environment(appModel)
            }

            ImmersiveSpace(id: appModel.immersivePlayerSpaceID) {
                ImmersiveView()
                    .environment(appModel)
                    .onAppear() {
                        appModel.immersiveSpaceState = .open
                    }
                    .onDisappear() {
                        appModel.immersiveSpaceState = .closed
                    }
            }
            .immersionStyle(selection: .constant(.progressive), in: .progressive, .full)

        }
        .onChange(of: appModel.wantsToPresentImmersiveSpace) {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                case .open:
                    appModel.immersiveSpaceState = .inTransition
                    await dismissImmersiveSpace()

                case .closed:
                    appModel.immersiveSpaceState = .inTransition
                    switch await openImmersiveSpace(id: appModel.immersivePlayerSpaceID) {
                    case .opened:
                        break

                    case .userCancelled, .error:
                        fallthrough

                    @unknown default:
                        appModel.immersiveSpaceState = .closed
                    }

                case .inTransition:
                    break
                }
            }
        }
    }
}
