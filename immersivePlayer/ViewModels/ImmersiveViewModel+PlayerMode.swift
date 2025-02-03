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
            let butterfly = try await spawnButterfly()
        case (.music, .radio):
            let butterfly = try await spawnButterfly()
        case (.music, .conversation):
            let butterfly = try await spawnButterfly()
        case (.radio, .music):
            let butterfly = try await spawnButterfly()
        case (.radio, .radio):
            let butterfly = try await spawnButterfly()
        case (.radio, .conversation):
            let butterfly = try await spawnButterfly()
        case (.conversation, .music):
            let butterfly = try await spawnButterfly()
        case (.conversation, .radio):
            let butterfly = try await spawnButterfly()
        case (.conversation, .conversation):
            let butterfly = try await spawnButterfly()
        }
    }
}
