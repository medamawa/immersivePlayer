//
//  ButterflyDance.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit

struct ButterflyDanceComponent: Component {
    init() {
        ButterflyDanceSystem.registerSystem()
    }
}

final class ButterflyDanceSystem: System {
    static let query = EntityQuery(
        where: (
            .has(CircularMotionComponent.self)
        )
    )

    init(scene: Scene){}

    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)

        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            var motion = entity.components[CircularMotionComponent.self]!

            // 角度を更新（円運動用）
            motion.angle += motion.speed * deltaTime
            if motion.angle > .pi * 2 { motion.angle -= .pi * 2 }

            // 経過時間を更新（サイン波用）
            motion.time += deltaTime

            // 円運動（X-Z平面）
            let newX = motion.radius * cos(motion.angle)
            let newZ = motion.radius * sin(motion.angle)

            // サイン波による上下運動（Y軸）
            let newY = motion.verticalAmplitude * sin(2 * .pi * motion.verticalFrequency * motion.time)

            // エンティティの位置を更新
            entity.position = [newX, newY, newZ]

            // 更新したコンポーネントを再設定
            entity.components.set(motion)

        }
    }
}

struct CircularMotionComponent: Component {
    var radius: Float
    var speed: Float
    var verticalAmplitude: Float
    var verticalFrequency: Float
    var angle: Float = 0
    var time: Float = 0
}
