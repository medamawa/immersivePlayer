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

    var immersiveSpaceState: ImmersiveSpaceState = .closed
}

enum ImmersiveSpaceState {
    case closed
    case inTransition
    case open
}
