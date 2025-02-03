//
//  Ball.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/02.
//

import SwiftUI
import RealityKit

class Ball {
    var position: SIMD3<Float>
    var entity: Entity

    // 円周の半径（直径2mなので半径は1m）
    let radius: Float = 1.0

    // 移動速度（角速度）
    var angularSpeed: Float = 0.1 // 1秒あたりの角度の増加量

    // 同期的に初期化するコンビニエンスイニシャライザ
    init(
        named name: String,
        in bundle: Bundle? = nil
    ) throws {
        self.position = [0, 0, 0]  // 初期位置を設定

        // bundleからEntityを同期的に読み込む
        do {
            // BundleからEntityを読み込む
            self.entity = try Entity.load(named: name, in: bundle)
        } catch {
            throw NSError(domain: "BallErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to load Entity from bundle."])
        }

        // Entityの初期位置を設定
        self.entity.position = position
    }

    func updatePosition(dt: Float) {
        // 角度を計算（時間に応じて角度が増加）
        let angle = angularSpeed * dt

        // 円周上の新しい位置を計算
        let x = radius * cos(angle)
        let z = radius * sin(angle)

        // 新しい位置を設定
        self.position = SIMD3<Float>(x, 0, z)
        self.entity.position = self.position
    }
}
