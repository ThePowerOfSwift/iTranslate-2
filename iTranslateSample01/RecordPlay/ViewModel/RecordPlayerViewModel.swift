//
//  RecordPlayerViewModel.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

class RecordPlayerViewModel: RecordPlayerViewModelProtocol {

    var delegate: RecordPlayerViewModelDelegate?

    var filePath = ""
    
    var playing = false
        
    convenience init(filePath: String) {
        self.init()
        
        self.filePath = filePath
    }
    
    func viewDidLoadInvoked() {
        handleToggleButtonTap()
    }
    
    func handleToggleButtonTap() {
        
        if let currentPlayer = AudioManager.shared.audioPlayer {
            playing = currentPlayer.isPlaying
         } else {
             return;
         }

         if !playing {
            let audioFilePath = Bundle.main.path(forResource: filePath, ofType: "m4a")
             if let path = audioFilePath {
                guard let fileURL = NSURL(string: path) else { return }
                AudioManager.shared.play(fileURL: fileURL as URL)
                
                delegate?.audioPlayDidStart()

             }

         } else {
            AudioManager.shared.pausePlaying()
            delegate?.audioPlayDidStop()
         }
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
