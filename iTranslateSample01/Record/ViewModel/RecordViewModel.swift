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
                    
                    welf.delegate?.getRecordNameFromUser(completion: { (text) in
                        RecordManager.shared.moveFile(from: recorder.url, toPath: welf.newFileLocation(name: text))
                    })

                }
                welf.delegate?.recordingDidStop()
            }
            else {
                RecordManager.shared.startRecording()
                welf.delegate?.recordingDidStart()
            }
        }
    }
    
    func newFileLocation(name: String) -> URL {
        let fileName = name + ".m4a"
        let audioFileUrl = RecordManager.shared.directoryUrl.appendingPathComponent(fileName)
        return audioFileUrl
    }
    
    func handleAllowRecordingFromPopUp() {
        RecordManager.shared.requestForPermission { [weak self] (status) in
            self?.handlePermissionStatus(status: status)
        }
    }
    
    func showRecordList() {
        
    }
}
