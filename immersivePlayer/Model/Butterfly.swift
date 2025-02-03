//
//  Butterfly.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI
import RealityKit

class Butterfly: Entity {
    private let body: ModelEntity
    private let leftWing: ModelEntity
    private let rightWing: ModelEntity

    private var flyTimer: Timer?
    private var flapTimer: Timer?

    required init(size: Float = 1.0) {
        // サイズに応じてスケールを調整
        let bodyRadius = 0.02 * size
        let wingWidth = 0.1 * size
        let wingHeight = 0.15 * size
        let wingOffset = 0.06 * size

        // 胴体と翼の作成
        body = ModelEntity(mesh: .generateSphere(radius: bodyRadius), materials: [SimpleMaterial(color: .black, isMetallic: false)])
        leftWing = ModelEntity(mesh: .generatePlane(width: wingWidth, height: wingHeight), materials: [SimpleMaterial(color: .orange, isMetallic: false)])
        rightWing = ModelEntity(mesh: .generatePlane(width: wingWidth, height: wingHeight), materials: [SimpleMaterial(color: .orange, isMetallic: false)])

        super.init()

        // 翼の配置
        leftWing.position = SIMD3(-wingOffset, 0, 0)
        rightWing.position = SIMD3(wingOffset, 0, 0)

        // 翼の角度調整
        leftWing.orientation = simd_quatf(angle: .pi / 6, axis: [0, 1, 0])
        rightWing.orientation = simd_quatf(angle: -.pi / 6, axis: [0, 1, 0])

        // 階層構造
        self.addChild(body)
        body.addChild(leftWing)
        body.addChild(rightWing)
    }
    
    @MainActor @preconcurrency required init() {
        fatalError("init() has not been implemented")
    }
    
    func startFlying() {
        flyUpDown()
        startWingFlapAnimation()
    }

    private func flyUpDown() {
        var movingUp = true
        flyTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let transform = Transform(translation: [0, movingUp ? 0.1 : 0, 0])
            self.move(to: transform, relativeTo: self.parent, duration: 1.0, timingFunction: .easeInOut)
            movingUp.toggle()
        }
    }

    private func startWingFlapAnimation() {
        var opening = true
        flapTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let angle: Float = opening ? .pi / 6 : -.pi / 6

            self.leftWing.setOrientation(simd_quatf(angle: angle, axis: [0, 0, 1]), relativeTo: self.leftWing.parent)
            self.rightWing.setOrientation(simd_quatf(angle: -angle, axis: [0, 0, 1]), relativeTo: self.rightWing.parent)

            opening.toggle()
        }
    }

    deinit {
        flyTimer?.invalidate()
        flapTimer?.invalidate()
    }
}

struct ButterflyView: View {
    @State private var butterflySize: Float = 1.0

    var body: some View {
        VStack {
            RealityView { content in
                let butterfly = Butterfly(size: butterflySize)
                butterfly.position = [0, 0, -0.5]
                butterfly.startFlying()

                let anchor = AnchorEntity(world: .zero)
                anchor.addChild(butterfly)
                content.add(anchor)
            }
            .frame(height: 400)

            // サイズ調整用スライダー
            Slider(value: $butterflySize, in: 0.5...3.0, step: 0.1) {
                Text("Butterfly Size")
            }
            .padding()

            Text(String(format: "Size: %.1fx", butterflySize))
                .font(.headline)
        }
    }
}

#Preview {
    ButterflyView()
}
