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

        return cdPlayer
    }

    func createCDPlayer() async throws -> ModelEntity {
        let cdPlayer = try await Entity.makeCDPlayer()

        cdPlayer.position = [0, 1, -1]

        rootEntity.addChild(cdPlayer)

        return cdPlayer
    }
}
