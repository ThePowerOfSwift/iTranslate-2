//
//  DataManager.swift
//  iTranslate
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    var database: Realm
    
    static let shared = DataManager()
    
    private init() {
        database = try! Realm()
    }
    
    // For unit testing
    init(database: Realm) {
        self.database = database
    }
    
    func getAll<T>(type: Object.Type) -> [T] {
        return (Array(database.objects(type)) as? [T]) ?? []
    }
    
    func save(objects: [Object], update: Bool = true) {
        try? database.write {
            database.add(objects, update: .modified)
        }
    }

    func removeAll(type: Object.Type) {
        let objects = database.objects(type)
        try? database.write {
            database.delete(objects)
        }
    }
    
    func remove(object: Object, update: Bool = true) {
        try? database.write {
            database.delete(object)
        }
    }
    
}
