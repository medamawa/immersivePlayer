//
//  Entity+Speaker.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import RealityKit

extension Entity {
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
