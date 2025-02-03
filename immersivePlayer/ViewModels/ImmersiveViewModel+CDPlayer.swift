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
        cdPlayer.position = [0, 1, -1]
        cdPlayer.fadeOpacity(from: 0, to: 1, duration: 1)

        return cdPlayer
    }

    func createCDPlayer() async throws -> ModelEntity {
        let cdPlayer = try await Entity.makeCDPlayer()

        rootEntity.addChild(cdPlayer)

        return cdPlayer
    }
}
