//
//  TimeIntervalExtensionTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/13/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import iTranslate

class TimeIntervalTest: QuickSpec{
   
    override func spec() {
        var timeInterval: TimeInterval!
        describe("Record") {
            
            beforeEach {
                let currentTime = Date()
                timeInterval = currentTime.timeIntervalSince(currentTime.addingTimeInterval(-600))
            }
            it ("Should save") {
                expect(timeInterval.stringValue()).to(equal("00:10:00"))
            }
        }
    }
}
