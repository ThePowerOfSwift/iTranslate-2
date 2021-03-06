//
//  RecordManager.swift
//  iTranslate
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
    
    typealias RecordCompletion = (_ recorder: AVAudioRecorder,_ duration: String, _ flag: Bool) -> ()
    var recordCompletion: RecordCompletion?
    
    var audioRecorder: AVAudioRecorder?
    
    var audioPlayer: AVAudioPlayer?
    
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
        try? recordingSession.setCategory(.playAndRecord, mode: .default)
        try? recordingSession.setActive(true)
        AVAudioSession.sharedInstance().requestRecordPermission({ (isGranted) in
            isGranted ? completion(.granted) : completion(.denied)
        })
    }
    
    func startRecording() {
        let audioFilename = FileDataManager.directoryUrl.appendingPathComponent("recording.mp4")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try? AVAudioRecorder(url: audioFilename, settings: settings)
        audioRecorder?.delegate = self
        audioRecorder?.record()
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
    
    func play(fileURL: URL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.numberOfLoops = -1 // play indefinitely
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            audioPlayer?.play()
        }
        catch {
            print(error)
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func resume() {
        audioPlayer?.play()
    }
}

extension AudioManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        let player = try? AVAudioPlayer(contentsOf: recorder.url)
        let duration = player?.duration ?? 0.0
        
        recordCompletion?(recorder,duration.stringValue(), flag)
    }
}

extension AudioManager: AVAudioPlayerDelegate {
    
}
