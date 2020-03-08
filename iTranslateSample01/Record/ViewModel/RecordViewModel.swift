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
        switch state {
        case .start:
            state = .stop
        case .stop:
            RecordManager.shared.checkPermissionStatus { [weak self] (status) in
                self?.handlePermissionStatus(status: status)
            }
        }
    }
    
    func handlePermissionStatus(status: PermissionStatus) {
        switch status {
        case .granted:
            state = .start
        case .undetermined:
            delegate?.showAudioPermissionAlert()
        case .denied: break
        }
    }
    
    func handleRecordState() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            if welf.state == .stop {
                RecordManager.shared.stopRecording()
                RecordManager.shared.recordCompletion = { (recorder, flag ) in
                    print(recorder.url)
                }
            }
            else {
                RecordManager.shared.startRecording()
            }
            
            
            (self?.state == .stop) ? self?.delegate?.recordingDidStop() : self?.delegate?.recordingDidStart()
        }
    }
    
    func handleAllowRecordingFromPopUp() {
        RecordManager.shared.requestForPermission { [weak self] (status) in
            self?.handlePermissionStatus(status: status)
        }
    }
    
    func showRecordList() {
        
    }
}
