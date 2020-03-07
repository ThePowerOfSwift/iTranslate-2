//
//  RecordViewModel.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

enum RecordState {
    case start
    case stop
}

class RecordViewModel: RecordViewModelProtocol {
    
    var delegate: RecordViewModelDelegate?
    
    func startRecording() {
        RecordManager.checkPermissionStatus { [weak self] (status) in
            switch status {
            case .granted:
                self?.delegate?.updateRecordButton(state: .start)
            case .denied, .undetermined:
                self?.delegate?.showAudioPermissionAlert()
            }
        }
    }
    
    func showRecordList() {
        
    }
}
