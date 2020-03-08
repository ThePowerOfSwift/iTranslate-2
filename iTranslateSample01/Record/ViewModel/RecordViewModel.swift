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
    
    var state: RecordState = .stop {
        didSet {
            handleRecordState()
        }
    }
    
    func handleRecordButtonTap() {
        if state == .start {
            state = .stop
        }
        else {
            RecordManager.checkPermissionStatus { [weak self] (status) in
                switch status {
                case .granted:
                    self?.state = .start
                case .denied, .undetermined:
                    self?.delegate?.showAudioPermissionAlert()
                }
            }
        }
    }
    
    func handleRecordState() {
        (state == .stop) ? delegate?.recordingDidStop() : delegate?.recordingDidStart()
    }
    
    func showRecordList() {
        
    }
}
