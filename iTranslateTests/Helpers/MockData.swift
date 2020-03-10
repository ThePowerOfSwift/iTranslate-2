//
//  MockData.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
@testable import iTranslate

class MockData {
    static var shared = MockData()
    
    private init() {
        var path =  MockFileDataManager.directoryUrl
        path.appendPathComponent("test.m4a")
        recordingFilePath = path
        
        FileManager.default.createFile(atPath: recordingFilePath.absoluteString, contents: nil, attributes: nil)
        record = Record(id: "test", filePath: recordingFilePath.absoluteString, name: "test", time: Date().stringValue())
    }
    
    let recordingFilePath: URL
    let record: Record
}
