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
class AppModel {
    let immersivePlayerSpaceID = "ImmersivePlayerSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}
