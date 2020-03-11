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
    
    weak var delegate: RecordViewModelDelegate?
    
    var state: RecordState = .stop {
        didSet {
            handleRecordState()
        }
    }
    
    private var newFileLocation: URL {
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
    
    private func createAudioRecord(_ recordName: String, url: URL, duration: String) {
        updateAudioFilePath(temporaryPath: url, completion: { [weak self] (result) in
            switch result {
            case .success(let destination):
                self?.addNewRecord(filePath: destination, name: recordName, time: duration)
            case .failure(let error):
                self?.delegate?.showError(type: .systemError, error: error)
            }
        })
    }
    
    private func handleRecordState() {
        DispatchQueue.main.async { [weak self] in
            guard let welf = self else { return }
            switch welf.state  {
            case .stop :
                AudioManager.shared.stopRecording()
                AudioManager.shared.recordCompletion = {(recorder, duration, flag ) in
                    welf.showPopUpToAddRecordName { (recordName) in
                        welf.createAudioRecord(recordName, url: recorder.url, duration: duration)
                    }
                }
                welf.delegate?.recordingDidStop()
            case .start :
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
        FileDataManager.moveFile(from: temporaryPath, toPath: destination) { (result) in
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
