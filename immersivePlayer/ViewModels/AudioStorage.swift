//
//  AudioStorage.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/04.
//

import RealityKit
import AVFoundation

@MainActor
final class AudioStorage {
    private var audioController: AudioPlaybackController?
    private var timer: Timer?

    @Published var currentTime: TimeInterval = 0

    func prepareAudio(for speaker: Entity, with url: URL) async throws {
        guard let audioSource = speaker.findEntity(named: "AudioSource-Speaker") else { return }
        let audioName: String = url.absoluteString
        let audio = try await AudioFileResource(
            contentsOf: url,
            withName: audioName,
            configuration: .init(shouldLoop: true)
        )
        stop()
        audioController = audioSource.prepareAudio(audio)
    }

    func play(from currentTime: TimeInterval) {
        audioController?.seek(to: Duration.seconds(currentTime))
        audioController?.play()
    }

    func pause() {
        audioController?.pause()
    }

    func stop() {
        audioController?.stop()
    }

    func seek(to time: TimeInterval) {
        audioController?.seek(to: Duration.seconds(currentTime))
    }

    func fadeOut() async throws {
        audioController?.fade(to: -.infinity, duration: 2)
    }
}

extension AudioPlaybackController {
    func playAndFadeIn(duration: TimeInterval) {
        gain = -.infinity
        fade(to: .zero, duration: duration)
        play()
    }

    func stopAndFadeOut(duration: TimeInterval) async throws {
        fade(to: -.infinity, duration: duration)
        try await Task.sleep(for: .seconds(Int(duration)))
        stop()
    }
}
