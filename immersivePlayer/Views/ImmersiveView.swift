//
//  ImmersiveView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import SwiftUI
import RealityKit

@MainActor
struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel

    @State private var viewModel = ImmersiveViewModel()

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
        .onChange(of: appModel.wantsToPresentImmersiveSpace) {
            if appModel.wantsToPresentImmersiveSpace {
                appModel.isPresentingImmersiveSpace = true
            } else {
                appModel.isPresentingImmersiveSpace = false
            }
        }
    }
}
