//
//  RecordPermissionAlertViewControllerTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/12/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import iTranslate

class RecordPermissionAlertViewControllerTests: QuickSpec {
    
    override func spec() {
        var viewController: RecordPermissionAlertViewController!
        var mockNavigationController: MockNavigationController!
        
        beforeEach {
            mockNavigationController = MockNavigationController(rootViewControllr: UIViewController())
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RecordPermissionAlertViewController.identifier) as? RecordPermissionAlertViewController
        }
        
        describe("Button action") {
            beforeEach {
                mockNavigationController.present(viewController, animated: false)
            }
            
            it("did allow permission") {
                viewController.allowPermissionButtonAction(UIButton())
                expect(mockNavigationController.presentedViewController).toEventually(beNil(), timeout: 5, pollInterval: 1, description: "Should dismiss alert")
            }
            
            it("did select may be later") {
                viewController.mayBeLaterButtonAction(UIButton())
                expect(mockNavigationController.presentedViewController).toEventually(beNil(), timeout: 5, pollInterval: 1, description: "Should dismiss alert")
            }
        }
    }
}
