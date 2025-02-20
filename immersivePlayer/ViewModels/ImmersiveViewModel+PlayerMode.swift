//
//  ImmersiveViewModel+PlayerMode.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit

extension ImmersiveViewModel {
    func transitionPlayerMode(from previous: PlayerMode, to current: PlayerMode) async throws {
        switch (previous, current) {
        case (.music, .music):
            butterflyEntity = try await spawnButterfly()
            speakerEntity = try await spawnCDPlayer()
            
        case (.music, .radio):
            try await fadeOutEntities()
            butterflyEntity = try await spawnButterfly()
            speakerEntity = try await spawnRadio()

        case (.radio, .music):
            try await fadeOutEntities()
            butterflyEntity = try await spawnButterfly()
            speakerEntity = try await spawnCDPlayer()

        case (.radio, .radio):
            butterflyEntity = try await spawnButterfly()
            speakerEntity = try await spawnRadio()
        }
    }
}
