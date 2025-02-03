//
//  Entity+Butterfly.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit
import RealityKitContent

extension Entity {
    static func makeButterfly() async throws -> ModelEntity {
        let butterfly = ModelEntity()
        butterfly.name = "butterfly"

        let butterflyModel = try await Entity(named: "Scene", in: realityKitContentBundle)
        butterflyModel.name = "butterflyModel"
        butterfly.addChild(butterflyModel)

//        butterfly.components.set(SpeedComponent())

        return butterfly
    }
}
