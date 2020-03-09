//
//  AudioPlayerViewController.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class AudioPlayerViewController: UIViewController, RecordPlayerModelController {
    
    var viewModel: RecordPlayerViewModel?
    
    var displayLink: CADisplayLink?
    
    @IBOutlet weak var playToggleButton: UIButton?
    @IBOutlet weak var audioProgressSlider: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self
        
        viewModel?.viewDidLoadInvoked()
    }

    @IBAction func playPauseToggleButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        viewModel?.handleToggleButtonTap()
    }
}

extension AudioPlayerViewController: RecordPlayerViewModelDelegate {
    func showAudioProgress(progressValue: Float) {
        audioProgressSlider?.setValue(progressValue, animated: false)
    }
    
    func audioPlayDidStart() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateSliderProgress))
        displayLink?.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
    }
    
    @objc func updateSliderProgress() {
        viewModel?.handleSliderProgress()
    }
    
    func audioPlayDidStop() {
        displayLink?.invalidate()
    }
    
    func showError(type: AlertController.Alert, error: Error?) {
        
    }
}
