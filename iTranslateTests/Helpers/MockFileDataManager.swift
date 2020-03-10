//
//  MockFileDataManager.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
@testable import iTranslate

class MockFileDataManager : FileDataManager {
        
    override class var directoryUrl: URL {
        let path = NSTemporaryDirectory()
        return URL(fileURLWithPath: path, isDirectory: true)
    }
}
