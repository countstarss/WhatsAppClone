//
//  VoiceMessagePlayer.swift
//  CloneChat
//
//  Created by luke on 2024/7/3.
//

import Foundation
import AVFoundation

final class VoiceMessagePlayer:ObservableObject {
    
    private var player : AVPlayer?
    private var currentURL: URL?
    
    private var playerItem:AVPlayerItem?
    private var playbackState = PlaybackState.stopped
    private var currentTime = CMTime.zero
    private var currentTimeObserver: Any?
    
    deinit{
        tearDown()
    }
    
    func playAudio(from url:URL) {
        if let currentURL = currentURL,currentURL == url {
            // resume a previous message that we were already playing
            resumePlaying()
        } else {
            //MARK: - SetUp AVPlayer
            currentURL = url
            let playerItem = AVPlayerItem(url: url)
            self.playerItem = playerItem
            player = AVPlayer(playerItem: playerItem)
            print("Successfully SetUp AVPlayer")
            
            // play voice message
            player?.play()
            playbackState = .playing
            observeCurrentPlayerTime()
            observeEndOfPlayback()
        }
        
    }
    
    func pauseAudio() {
        player?.pause()
        playbackState = .stopped
    }
    
    func seek(to timeInterval:TimeInterval) {
        guard let player = player else { return }
        let targetTime = CMTime(seconds: 1, preferredTimescale: 1)
        player.seek(to: targetTime)
    }
    
    //MARK: - Private Methods
    
    private func resumePlaying() {
        if playbackState == .paused || playbackState == .stopped {
            player?.play()
            playbackState = .playing
        }
    }
    
    // 这个主要是为了跟踪拖动条
    private func observeCurrentPlayerTime(){
        currentTimeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main){ [weak self]  time in
            self?.currentTime = time
            print("observeCurrentPlayerTime：\(time)")
        }
    }
    
    private func observeEndOfPlayback() {
        NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: player?.currentItem, queue: .main) { [weak self] _ in
            self?.stopAudioPlayer()
            print("observeEndOfPlayback")
            
        }
    }
    
    // 回到起点
    private func stopAudioPlayer() {
        player?.pause()
        player?.seek(to: .zero)
        playbackState = .stopped
        currentTime = .zero
    }
    
    private func removeObservers() {
        guard let currentTimeObserver else { return }
        player?.removeTimeObserver(currentTimeObserver)
        self.currentTimeObserver = nil
        print("CurrentTimeObserver Was Fired")
    }
    
    private func tearDown() {
        removeObservers()
        player = nil
        playerItem = nil
        currentURL = nil
    }
    
}

extension VoiceMessagePlayer {
    enum PlaybackState {
        case stopped,playing,paused
        
    }
}
