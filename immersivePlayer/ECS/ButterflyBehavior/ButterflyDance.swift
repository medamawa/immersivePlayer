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
            let newY = 1.7 + motion.verticalAmplitude * sin(2 * .pi * motion.verticalFrequency * motion.time)

            // エンティティの位置を更新
            entity.position = [newX, newY, newZ]

            // 進行方向のベクトル（XZ平面）
            var tangent = SIMD3<Float>(-sin(motion.angle), 0, cos(motion.angle))

            // Y方向の速度を加味（dy/dt）
            let verticalSpeed = motion.verticalAmplitude * 2 * .pi * motion.verticalFrequency * cos(2 * .pi * motion.verticalFrequency * motion.time)
            tangent.y = verticalSpeed

            // 正規化
            tangent = normalize(tangent)

            // 法線ベクトル（右方向）
            let upReference = SIMD3<Float>(0, 1, 0)
            let right = normalize(cross(upReference, tangent))

            // 上向きベクトルを再計算
            let up = normalize(cross(tangent, right))

            // 修正された回転行列（列ベクトルとして渡す）
            let rotationMatrix = simd_float3x3(right, up, tangent)

            // Rotationを適用（回転行列をクォータニオンに変換）
            entity.orientation = simd_quatf(rotationMatrix)

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
