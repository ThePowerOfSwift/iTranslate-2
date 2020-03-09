//
//  RecordPlayerViewModel.swift
//  iTranslateSample01
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

    var delegate: RecordPlayerViewModelDelegate?

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

//         if !playing {
//           // let audioFilePath = Bundle.main.path(forResource: filePath, ofType: "m4a")
//        //     if let path =  {
//
//
//            // }
//
//         } else {
//
//         }
    }
    
    func handleSliderProgress() {
        if let player = AudioManager.shared.audioPlayer {
            let progress = player.currentTime / player.duration
            delegate?.showAudioProgress(progressValue: Float(progress))
        }
        else {
            delegate?.showAudioProgress(progressValue: 0.0)
        }

    }
}
