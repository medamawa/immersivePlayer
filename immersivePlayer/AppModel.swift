//
//  AppModel.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
final class AppModel {

    let immersivePlayerSpaceID = "ImmersivePlayerSpace"

    var playerMode: PlayerMode = .music

    var isPresentingPlayerView = false
    var immersiveSpaceState: ImmersiveSpaceState = .closed
    var wantsToPresentImmersiveSpace = false

    var isTransitioningBetweenPlayerMode = false

    var isAudioFileAvailable = false
}

enum PlayerMode: String, CaseIterable {
    case music
    case radio
    case conversation
}

enum ImmersiveSpaceState {
    case closed
    case inTransition
    case open
}
