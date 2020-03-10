//
//  AlertControllerTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
@testable import iTranslate

class AlertControllerTests: QuickSpec {
    override func spec() {
        
        context("did show alert") {
            beforeEach {
                MockAlertController.show(type: .systemError)
            }
            
            it("check to show alert") {
                print(MockAlertController.topMostViewController())
            }
        }
    }
    
    class MockAlertController : AlertController {
        override class func topMostViewController() -> UIViewController {
            let vc =  MockNavigationController().topViewController ?? UIViewController()
            _ = vc.view
            return vc
        }
    }
}
