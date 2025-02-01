//
//  ImmersivePlayerSpace.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersivePlayerSpace: View {
    @Environment(AppModel.self) var appModel

    var body: some View {
        RealityView() { content in
            if let butterflyEntity = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(butterflyEntity)
            }
        }
    }
}

#Preview(immersionStyle: .progressive) {
    ImmersivePlayerSpace()
        .environment(AppModel())
}
