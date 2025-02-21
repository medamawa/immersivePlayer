//
//  AppModel.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

// !! TODO !!
// PlayerView起動時に再生可能になってしまっている
// PlayerViewを閉じたらアプリを終了させたい
// [DONE] Speaker切り替え時に音楽再生をやめる
// [DONE] Speaker切り替え時の状態にinTransitionを追加


import SwiftUI
import RealityKit

/// Maintains app-wide state
@MainActor
@Observable
final class AppModel {

    let immersivePlayerSpaceID = "ImmersivePlayerSpace"
    var immersionStyle: ImmersionStyle = .mixed

    var playerMode: PlayerMode = .music

    var isPresentingPlayerView = false
    var immersiveSpaceState: ImmersiveSpaceState = .closed
    var wantsToPresentImmersiveSpace = false

    var isTransitioningBetweenPlayerMode = false

    var isAudioFileAvailable = false
    var audioFileURL: URL? = nil
    var audioPlayerState: AudioPlayerState = .stopped
    var currentTime: TimeInterval = 0
}

enum PlayerMode: String, CaseIterable {
    case music
    case radio
//    case conversation
}

enum ImmersiveSpaceState {
    case closed
    case inTransition
    case open
}

enum AudioPlayerState {
    case playing
    case paused
    case stopped
    case seek
}
