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
        radio.position = speakerInitialPosition()
        radio.fadeOpacity(from: 0, to: 1, duration: 1)

        return radio
    }

    func createRadio() async throws -> ModelEntity {
        let radio = try await Entity.makeRadio()

        rootEntity.addChild(radio)

        return radio
    }
}
