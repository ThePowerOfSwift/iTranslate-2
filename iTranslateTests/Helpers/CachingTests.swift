//
//  CachingTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//


import Quick
import Nimble
import RealmSwift
@testable import iTranslate

class CachingTests: QuickSpec {
    
    override func spec() {
        describe("Record") {
            beforeEach() {
                MockData.shared.record.save()
            }
            
            it ("Should save") {
                expect(Record.cached().count).to(beGreaterThan(0))
            }
        }
        
        describe("Record") {
            beforeEach() {
                MockData.shared.record.save()
            }
            
            it ("should get all") {
                expect(Record.cached().count).to(beGreaterThan(0))
            }
        }
        
        describe("Record") {
            beforeEach() {
                Record.removeAll()
            }
            
            it ("should delete") {
                expect(Record.cached().count).to(equal(0))
            }
        }
    }
}
    
extension Caching where Self: BaseObject {

    func save() {
        MockDataManager.shared.save(objects: [self])
    }

    // get all values from database
    static func cached() -> [Self] {
        return MockDataManager.shared.getAll(type: self)
    }
    
    static func removeAll() {
        return MockDataManager.shared.removeAll(type: self)
    }
}
