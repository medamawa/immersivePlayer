//
//  Entity+CDPlayer.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit
import RealityKitContent

extension Entity {
    static func makeCDPlayer() async throws -> ModelEntity {
        let cdPlayer = ModelEntity()
        cdPlayer.name = "cdPlayer"

        let cdPlayerModel = try await Entity(named: "Radio", in: realityKitContentBundle)
        cdPlayerModel.name = "cdPlayerModel"
        cdPlayer.addChild(cdPlayerModel)

        return cdPlayer
    }
}
