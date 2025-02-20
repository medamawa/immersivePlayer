//
//  ImmersiveViewModel.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import RealityKit

@MainActor
final class ImmersiveViewModel {
    let rootEntity = Entity()

    var butterflyEntity: ModelEntity?

    var speakerEntity: ModelEntity?
    let speakerAudio = AudioStorage()
    var speakerPosition: SIMD3<Float> = [0, 1.5, -1]

}
