//
//  ImmersiveViewModel+Butterfly.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit

extension ImmersiveViewModel {
    func spawnButterfly() async throws -> ModelEntity {
        let butterfly = try await createButterfly()

        return butterfly
    }

    func createButterfly() async throws -> ModelEntity {
        let butterfly = try await Entity.makeButterfly()

        let circularMotion = CircularMotionComponent(
            radius: 1.0,
            speed: .pi / 4,
            verticalAmplitude: 0.5,
            verticalFrequency: 0.2
        )

        butterfly.components.set(circularMotion)
        butterfly.components.set(ButterflyDanceComponent())

        rootEntity.addChild(butterfly)

        return butterfly
    }

}
