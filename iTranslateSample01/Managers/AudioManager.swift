//
//  RecordManager.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

typealias PermissionStatusCompletion = ((PermissionStatus) -> Void)

enum PermissionStatus {
    case granted
    case denied
    case undetermined
}

class AudioManager: NSObject {
    
    static let shared = AudioManager()
    
    typealias RecordCompletion = (_ recorder: AVAudioRecorder, _ flag: Bool) -> ()
    var recordCompletion: RecordCompletion?
    
    var directoryUrl: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    var audioRecorder: AVAudioRecorder?
    
    private override init() { }
    
    let recordingSession = AVAudioSession.sharedInstance()
    
    func checkPermissionStatus(completion: PermissionStatusCompletion) {
        switch recordingSession.recordPermission {
        case AVAudioSessionRecordPermission.granted:
            completion(.granted)
        case AVAudioSessionRecordPermission.denied:
            completion(.denied)
        case AVAudioSessionRecordPermission.undetermined:
            completion(.undetermined)
        @unknown default:
            break
        }
    }
    
    func requestForPermission(completion: @escaping PermissionStatusCompletion) {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            AVAudioSession.sharedInstance().requestRecordPermission({ (isGranted) in
                isGranted ? completion(.granted) : completion(.denied)
            })
        }
        catch {
            
        }
    }
    
    func startRecording() {
        let audioFilename = directoryUrl.appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()

        } catch {
            
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
    
    func moveFile(from path: URL, toPath: URL, completion: (Result<Bool,Error>) -> Void) {
        do {
            try FileManager.default.moveItem(at: path, to: toPath)
            completion(.success(true))
        }
        catch { 
            completion(.failure(error))
        }
    }
}

extension AudioManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recordCompletion?(recorder, flag)
    }
}
