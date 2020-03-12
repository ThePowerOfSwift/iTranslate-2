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
    }
    
    let recordingFilePath: URL
    var record: Record {
       return Record(id: Date().stringValue(), filePath: recordingFilePath.absoluteString, name: "test", time: Date().stringValue())
    }

}
