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

//        butterfly.playAnimation(butterfly.availableAnimations[0].repeat())

        rootEntity.addChild(butterfly)

        return butterfly
    }

    func fadeOutEntities() async throws {

        guard let butterflyEntity else { return }
        guard let speakerEntity else { return }

        butterflyEntity.fadeOpacity(from: 1, to: 0, duration: 0.5)
        speakerEntity.fadeOpacity(from: 1, to: 0, duration: 0.5)
        try await speakerAudio.fadeOut()

        try await Task.sleep(for: .seconds(1))

        butterflyEntity.removeFromParent()
        speakerEntity.removeFromParent()
        self.butterflyEntity = nil
        self.speakerEntity = nil
    }

}
