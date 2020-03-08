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
    
    var newFileLocation: URL {
        let fileName = "\(Record.cached().count)" + ".m4a"
        let audioFileUrl = AudioManager.shared.directoryUrl.appendingPathComponent(fileName)
        return audioFileUrl
    }
    
    func handleRecordButtonTap() {
        switch state {
        case .start:
            state = .stop
        case .stop:
            AudioManager.shared.checkPermissionStatus { [weak self] (status) in
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
                AudioManager.shared.stopRecording()
                AudioManager.shared.recordCompletion = { (recorder, flag ) in
                    print(recorder.url)
                    welf.showPopUpToAddRecordName(temporaryPath: recorder.url)

                }
                welf.delegate?.recordingDidStop()
            }
            else {
                AudioManager.shared.startRecording()
                welf.delegate?.recordingDidStart()
            }
        }
    }
    
    func addNewRecord(filePath: URL, name: String) {
        let records = Record.cached()
        
        let record = Record(id: ("\(records.count + 1)"), filePath: filePath.absoluteString, name: name)
        record.save()
    }
    
    func showPopUpToAddRecordName(temporaryPath: URL) {
        delegate?.getRecordNameFromUser(completion: { [weak self] (text) in
            guard let destination = self?.newFileLocation else { return }

            self?.updateAudioFilePath(temporaryPath: temporaryPath, destination: destination, recordName: text)
        })
    }
    
    func updateAudioFilePath(temporaryPath: URL, destination: URL, recordName: String) {
        AudioManager.shared.moveFile(from: temporaryPath, toPath: destination) { [weak self] (result) in
            switch result {
            case .success:
                self?.addNewRecord(filePath: destination, name: recordName)
            case .failure(let error):
                self?.delegate?.showError(type: .systemError, error: error)
            }
        }
    }
    
    func handleAllowRecordingFromPopUp() {
        AudioManager.shared.requestForPermission { [weak self] (status) in
            self?.handlePermissionStatus(status: status)
        }
    }
    
    func showRecordList() {
        
    }
}
