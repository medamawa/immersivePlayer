//
//  ImmersivePlayerSpace.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersivePlayerSpace: View {
    @Environment(AppModel.self) var appModel

    @State private var ballEntity: Ball?
    @State private var timer: Timer?

    private let animationDT: Float = 1.0 / 60.0

    var body: some View {
        // 足元が原点、x軸が右、y軸が上、z軸が手前
        RealityView() { content in
            // butterflyはひとまず球体で代替しておく
            //            if let butterflyEntity = try? await Entity(named: "butterfly"),
            //               let animation = butterflyEntity.availableAnimations.first {
            //                butterflyEntity.position = [0, 1, -2]
            //                butterflyEntity.playAnimation(animation.repeat())
            //                content.add(butterflyEntity)
            //            }
            //            if let sceneEntity = try? await Entity(named: "Scene", in: realityKitContentBundle) {
            //                sceneEntity.position = [0, 1.5, -1]
            //                content.add(sceneEntity)
            //            }
            ballEntity = try! Ball(named: "Scene", in: realityKitContentBundle)
            content.add(ballEntity!.entity)

            self.timer = Timer.scheduledTimer(withTimeInterval: Double(animationDT), repeats: true) { _ in
                ballEntity!.updatePosition(dt: animationDT)
            }

        }
        //        .gesture(tapGesture)
    }

//    var tapGesture: some Gesture {
//        TapGesture()
//            .targetedToAnyEntity()
//            .onEnded { value in
//
//                switch value.entity.name {
//                case "butterfly":
//                    print("Tapped butterfly")
//
//                case "Scene":
//                    // 動かすPosition
//                    let newPosition = SIMD3<Float>(2, 1.5, -2)
//
//                    var newTransform = self.sceneEntity.transform
//                    newTransform.translation = newPosition
//                    self.sceneEntity.move(to: newTransform, relativeTo: nil, duration: 1.0, timingFunction: .linear)
//
//                default: break
//                }
//        }
//    }
}

#Preview(immersionStyle: .progressive) {
    ImmersivePlayerSpace()
        .environment(AppModel())
}

