//
//  Record.swift
//  iTranslate
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

class Record: BaseObject {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var time = ""
    @objc dynamic var filePath = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, filePath: String, name: String, time: String) {
        self.init()
        
        self.id = id
        self.filePath = filePath
        self.name = name
        self.time = time
    }
}
