//
//  Entity+Speaker.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import RealityKit
import RealityKitContent

extension Entity {
    static func makeCDPlayer() async throws -> ModelEntity {
        let cdPlayer = ModelEntity()
        cdPlayer.name = "cdPlayer"

        let cdPlayerModel = try await Entity(named: "CDPlayer", in: realityKitContentBundle)
        cdPlayerModel.name = "cdPlayerModel"
        cdPlayer.addChild(cdPlayerModel)

        try await configureSpeakerAudioSource(on: cdPlayer)

        return cdPlayer
    }

    static func makeRadio() async throws -> ModelEntity {
        let radio = ModelEntity()
        radio.name = "radio"

        let radioModel = try await Entity(named: "Radio", in: realityKitContentBundle)
        radioModel.name = "radioModel"
        radio.addChild(radioModel)

        try await configureSpeakerAudioSource(on: radio)

        return radio
    }

    static func configureSpeakerAudioSource(on speaker: Entity) async throws {
        let audioSource = Entity()
        audioSource.name = "AudioSource-Speaker"
        audioSource.orientation = .init(angle: .pi, axis: [0, 1, 0])
        audioSource.components.set(SpatialAudioComponent(directivity: .beam(focus: 0.8)))
        speaker.addChild(audioSource)
    }

    func fadeOpacity(from start: Float? = nil, to end: Float, duration: Double) {
        let start = start ?? components[OpacityComponent.self]?.opacity ?? 0
        let fadeInAnimationDefinition = FromToByAnimation(
            from: Float(start),
            to: Float(end),
            duration: duration,
            timing: .easeInOut,
            bindTarget: .opacity
        )
        let fadeInAnimation = try! AnimationResource.generate(with: fadeInAnimationDefinition)
        components.set(OpacityComponent(opacity: start))
        playAnimation(fadeInAnimation)
    }
}
