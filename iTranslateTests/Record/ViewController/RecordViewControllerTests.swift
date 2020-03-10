//
//  RecordViewControllerTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import iTranslate

class RecordViewControllerTests: QuickSpec {
    
    override func spec() {
        var recordViewController: RecordViewController!
        var mockNavigationController: MockNavigationController!
        
        beforeEach {

            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            recordViewController = storyboard.instantiateViewController(withIdentifier: RecordViewController.identifier) as? RecordViewController
             mockNavigationController = MockNavigationController(rootViewController: recordViewController)
             let window = UIWindow(frame: UIScreen.main.bounds)
             window.rootViewController = mockNavigationController
             window.makeKeyAndVisible()
             recordViewController.loadView()
        }
        
        describe("Record animation") {
            
            it("recording Did Start") {
                recordViewController.recordingDidStart()
                expect(recordViewController.view.subviews.contains(recordViewController.animationView)).to(equal(true))

            }
            
            it("should start animation") {
                recordViewController.startRecordAnimation()
                expect(recordViewController.view.subviews.contains(recordViewController.animationView)).to(equal(true))
            }
            
            it("recording Did Stop") {
                recordViewController.recordingDidStop()
                expect(recordViewController.view.subviews.contains(recordViewController.animationView)).to(equal(false))

            }
            
            it("should stop animation") {
                recordViewController.stopRecordAnimation()
                expect(recordViewController.view.subviews.contains(recordViewController.animationView)).to(equal(false))
            }
        }
        
        describe("Display alert") {
            it("should show pop up") {
                recordViewController.getRecordNameFromUser { (_) in}
                expect(recordViewController.presentedViewController).toNot(beNil())
            }
        }
        
        describe("Permission alert") {
            it("should show") {
                recordViewController.showAudioPermissionAlert()
                expect(recordViewController.presentedViewController).toNot(beNil())
                expect(recordViewController.presentedViewController).to(beAKindOf(RecordPermissionAlertViewController.self))

            }
        }
        
        describe("Error") {
            it("should show error pop up") {
                recordViewController.showError(type: .systemError, error: nil)
                expect(mockNavigationController.topViewController).toNot(beAKindOf(AlertController.self))
            }
        }
        
        describe("display listing screen") {
            it("should show error pop up") {
                recordViewController.showRecordListingScreen()
                expect(mockNavigationController.pushedViewController).to(beAKindOf(RecordListViewController.self))
            }
        }
    }
}

