//
//  ImmersiveViewModel+Speaker.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import SwiftUI
import RealityKit

extension ImmersiveViewModel {

    func fadeOutSpeaker() async throws {

        guard let speakerEntity else { return }

        speakerEntity.fadeOpacity(from: 1, to: 0, duration: 0.5)
        try await speakerAudio.fadeOut()

        try await Task.sleep(for: .seconds(1))

        speakerEntity.removeFromParent()
        self.speakerEntity = nil
    }
}
