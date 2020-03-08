//
//  Record.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

class Record: BaseObject {
    @objc dynamic var id = ""
    @objc dynamic var filePath = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, filePath: String) {
        self.init()
        
        self.id = id
        self.filePath = filePath
    }
}
