//
//  RecordPlayerViewModel.swift
//  iTranslate
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

enum PlayMode {
    case playing
    case paused
    case notStarted
}

class RecordPlayerViewModel: RecordPlayerViewModelProtocol {

    weak var delegate: RecordPlayerViewModelDelegate?

    var filePath = ""
    
    var playMode: PlayMode = .notStarted
        
    convenience init(filePath: String) {
        self.init()
        
        self.filePath = filePath
    }
    
    func viewDidLoadInvoked() {
        handleToggleButtonTap()
    }
    
    func handleToggleButtonTap() {
        
        if let currentPlayer = AudioManager.shared.audioPlayer {
            playMode = currentPlayer.isPlaying ? .playing : .paused
         }

        switch playMode {
        case .playing:
            playMode = .paused
            AudioManager.shared.pause()
            delegate?.audioPlayDidStop()
        case .notStarted:
            guard let fileURL = NSURL(string: filePath) else { return }
            AudioManager.shared.play(fileURL: fileURL as URL)
            delegate?.audioPlayDidStart()
            playMode = .playing
        case .paused:
            AudioManager.shared.resume()
            playMode = .playing
            delegate?.audioPlayDidStart()
        }
    }
    
    func handleSliderProgress() {
        if let player = AudioManager.shared.audioPlayer,player.duration != 0 {
            let progress = player.currentTime / player.duration
            delegate?.showAudioProgress(progressValue: Float(progress))
        }
        else {
            delegate?.showAudioProgress(progressValue: 0.0)
        }

    }
    
    func viewAboutToDisappear() {
        AudioManager.shared.stop()
        delegate?.audioPlayDidStop()
    }
}
