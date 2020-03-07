//
//  RecordManager.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

typealias PermissionStatusCompletion = ((PermissionStatus) -> Void)

enum PermissionStatus {
    case granted
    case denied
    case undetermined
}

class RecordManager {
    
    static func checkPermissionStatus(completion: PermissionStatusCompletion) {
        switch AVAudioSession.sharedInstance().recordPermission {
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
    
    static func requestForPermission(completion: @escaping PermissionStatusCompletion) {
        AVAudioSession.sharedInstance().requestRecordPermission({ (isGranted) in
            isGranted ? completion(.granted) : completion(.denied)
        })
    }
}
