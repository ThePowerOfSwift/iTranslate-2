//
//  RecordViewController.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, RecordModelController {
    
    var viewModel: RecordViewModel {
        RecordViewModel()
    }
    
    @IBOutlet weak var recordButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }

    @IBAction func recordButtonAction(_ sender: UIButton) {
        viewModel.startRecording()
    }
    
    @IBAction func showRecordingButtonAction(_ sender: UIButton) {
        viewModel.showRecordList()
    }
}

extension RecordViewController: RecordViewModelDelegate {
    
    func showAudioPermissionAlert() {
        guard let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RecordPermissionAlertViewController.identifier) as? RecordPermissionAlertViewController else { return }
        alertView.allowCompletion = {
            
        }
        alertView.laterCompletion = {
            
        }
        present(alertView, animated: true, completion: nil)
    }
    
    func updateRecordButton(state: RecordState) {
        if state == .start {
            // started
        }
        else {
            // stopped
        }
    }
    
    
}
