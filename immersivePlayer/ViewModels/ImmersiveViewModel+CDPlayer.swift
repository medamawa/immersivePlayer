//
//  ImmersiveViewModel+CDPlayer.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit

extension ImmersiveViewModel {
    func spawnCDPlayer() async throws -> ModelEntity {
        let cdPlayer = try await createCDPlayer()
        cdPlayer.position = speakerPosition
        cdPlayer.fadeOpacity(from: 0, to: 1, duration: 0.5)

        return cdPlayer
    }

    func createCDPlayer() async throws -> ModelEntity {
        let cdPlayer = try await Entity.makeCDPlayer()

        cdPlayer.components.set(CollisionComponent(shapes: [.generateBox(width: 0.3, height: 0.15, depth: 0.2)]))
        cdPlayer.components.set(InputTargetComponent())

        rootEntity.addChild(cdPlayer)

        return cdPlayer
    }
}
