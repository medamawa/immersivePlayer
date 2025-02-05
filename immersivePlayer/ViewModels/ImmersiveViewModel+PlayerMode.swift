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
            speakerEntity = try await spawnCDPlayer()
            
        case (.music, .radio):
            let butterfly = try await spawnButterfly()
            try await fadeOutSpeaker()
            speakerEntity = try await spawnRadio()

        case (.radio, .music):
            let butterfly = try await spawnButterfly()
            try await fadeOutSpeaker()
            speakerEntity = try await spawnCDPlayer()

        case (.radio, .radio):
            let butterfly = try await spawnButterfly()
            speakerEntity = try await spawnRadio()
        }
    }
}
