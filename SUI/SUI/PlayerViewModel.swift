//
//  PlayerViewModel.swift
//  SUI
//
//  Created by angelina on 19.01.2023.
//

import AVFoundation

/// Модель плеера
final class PlayerViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let songsValues = ["gori", "dymd", "newYear"]
        static let songTypeString = "mp3"
        static let timeInterval = 0.1
        static let stubDouble = 0.0
        static let songIndex = 0
        static let zeroNumber = 0
        static let oneNumber = 1
    }
    
    // MARK: - Public properties
    
    @Published var maxDuration = Constants.stubDouble
    @Published var currentDuration: Double = Constants.stubDouble
    var player: AVAudioPlayer?
    
    // MARK: - Private properties
    
    private var isWorkTimer = false
    private var songs = Constants.songsValues
    private var songIndex = Constants.songIndex
    
    // MARK: - Public methods
    
    func play() {
        playSong(name: songs[songIndex])
        player?.play()
        setTime(value: Float(currentDuration))
    }
    
    func stop() {
        isWorkTimer = true
        player?.stop()
    }
    
    func previousSong() {
        stop()
        guard songIndex > Constants.zeroNumber else { return }
        songIndex -= Constants.oneNumber
        playSong(name: songs[songIndex])
        player?.play()
        setupTimer()
    }
    
    func nextSong() {
        stop()
        guard songIndex < songs.count else { return }
        songIndex += Constants.oneNumber
        playSong(name: songs[songIndex])
        player?.play()
        setupTimer()
    }
    
    func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.currentDuration = Double(self.player?.currentTime ?? Constants.stubDouble)
            if Int(self.currentDuration) >= Int(self.maxDuration) {
                self.nextSong()
                timer.invalidate()
            }
            if self.isWorkTimer {
                timer.invalidate()
            }
        }
    }
    
    func setupPhotoName() -> String {
        return songs[songIndex]
    }
    
    func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
        setupTimer()
    }
    
    // MARK: - Private methods
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: Constants.songTypeString) else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? Constants.stubDouble
        } catch {
            print(error.localizedDescription)
        }
    }
}
