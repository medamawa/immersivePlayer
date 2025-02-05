//
//  ImmersiveViewModel+Speaker.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import RealityKit

extension ImmersiveViewModel {
    func speakerInitialPosition() -> SIMD3<Float> {
        return [0, 1.5, -1]
    }

    func fadeOutSpeaker() async throws {

        guard let speakerEntity else { return }

        speakerEntity.fadeOpacity(from: 1, to: 0, duration: 1)
        try await speakerAudio.fadeOut()

        try await Task.sleep(for: .seconds(1))

        speakerEntity.removeFromParent()
        self.speakerEntity = nil
    }
}
