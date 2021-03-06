//
//  Caching.swift
//  iTranslate
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol Caching {}

extension Caching where Self: BaseObject {
    
    func save() {
        DispatchQueue.main.async {
            DataManager.shared.save(objects: [self])
        }
    }
    
    // get all values from database
    static func cached() -> [Self] {
        return DataManager.shared.getAll(type: self)
    }
    
    func delete() {
        DataManager.shared.remove(object: self)
    }
}
