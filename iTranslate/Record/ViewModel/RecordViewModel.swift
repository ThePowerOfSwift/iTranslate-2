//
//  RecordViewModel.swift
//  iTranslate
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

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
        let fileName = Date().stringValue() + ".m4a"
        let audioFileUrl = FileDataManager.directoryUrl.appendingPathComponent(fileName)
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
                AudioManager.shared.recordCompletion = { [weak self] (recorder, duration, flag ) in
                    print(recorder.url)

                    welf.showPopUpToAddRecordName { (recordName) in
                        self?.updateAudioFilePath(temporaryPath: recorder.url, completion: { (result) in
                            switch result {
                            case .success(let destination):
                                self?.addNewRecord(filePath: destination, name: recordName, time: duration)
                            case .failure(let error):
                                self?.delegate?.showError(type: .systemError, error: error)
                            }
                        })
                    }
                }
                welf.delegate?.recordingDidStop()
            }
            else {
                AudioManager.shared.startRecording()
                welf.delegate?.recordingDidStart()
            }
        }
    }
    
    func addNewRecord(filePath: URL, name: String, time: String) {        
        let record = Record(id: Date().stringValue(), filePath: filePath.absoluteString, name: name, time: time)
        record.save()
    }
    
    func showPopUpToAddRecordName(completion: StringCompletion? = nil) {
        delegate?.getRecordNameFromUser(completion: {(text) in
            completion?(text)
        })
    }
    
    func updateAudioFilePath(temporaryPath: URL, completion: (Result<URL,Error>) -> Void) {
        let destination = newFileLocation
        AudioManager.shared.moveFile(from: temporaryPath, toPath: destination) { (result) in
            switch result {
                case .success:
                    completion(.success(destination))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func handleAllowRecordingFromPopUp() {
        AudioManager.shared.requestForPermission { [weak self] (status) in
            self?.handlePermissionStatus(status: status)
        }
    }
    
    func showRecordingsButtonTapped() {
        delegate?.showRecordListingScreen()
    }

}
