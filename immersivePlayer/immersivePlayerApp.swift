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
                MenuView(appModel: appModel)
                    .fixedSize()
            }
            .windowResizability(.contentSize)

            WindowGroup(id: "AudioPlayer") {
                PlayerView(appModel: appModel)
                    .fixedSize()
                    .onAppear() {
                        appModel.isPresentingPlayerView = true
                    }
                    .onDisappear() {
                        appModel.isPresentingPlayerView = false
                    }
            }
            .windowResizability(.contentSize)

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
            .immersionStyle(selection: $appModel.immersionStyle, in: .mixed, .progressive)

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
        .onChange(of: appModel.audioPlayerState) {
            if appModel.audioPlayerState == .paused {
                print("paused")
            } else if appModel.audioPlayerState == .playing {
                print("playing")
            }
        }
    }
}
