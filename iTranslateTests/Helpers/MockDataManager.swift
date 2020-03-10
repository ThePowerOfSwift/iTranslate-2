//
//  MockDataManager.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import RealmSwift
@testable import iTranslate

class MockObject: Object {}

class MockDataManager: DataManager {
    
    init() {
        let database = try! Realm()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "AudioTranscriberTest"
        super.init(database: database)
    }
}
