//
//  ImmersiveViewModel+Radio.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/05.
//

import RealityKit

extension ImmersiveViewModel {
    func spawnRadio() async throws -> ModelEntity {
        let radio = try await createRadio()
        radio.position = speakerPosition
        radio.fadeOpacity(from: 0, to: 1, duration: 0.5)

        return radio
    }

    func createRadio() async throws -> ModelEntity {
        let radio = try await Entity.makeRadio()

        radio.components.set(CollisionComponent(shapes: [.generateBox(width: 0.3, height: 0.2, depth: 0.1)]))
        radio.components.set(InputTargetComponent())

        rootEntity.addChild(radio)

        return radio
    }
}
