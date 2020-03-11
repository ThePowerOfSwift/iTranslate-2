//
//  RecordPlayerViewControllerTests.swift
//  iTranslateTests
//
//  Created by sajeev Raj on 3/11/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
@testable import iTranslate

class RecordPlayerViewControllerTests: QuickSpec {
    class MockRecordPlayerViewModel: RecordPlayerViewModel {

        var didViewLoadInvoked = false
        var didHandleSliderProgress = false
        var didHandleToggleButtonTap = false
        var didCallViewAboutToDisappear = false

        override func viewDidLoadInvoked() {
            didViewLoadInvoked = true
        }
        
        override func handleSliderProgress() {
            didHandleSliderProgress = true
        }
        
        override func handleToggleButtonTap() {
            didHandleToggleButtonTap = true
        }
        
        override func viewAboutToDisappear() {
            didCallViewAboutToDisappear = true
        }
        
    }
    
    override func spec() {
        var recordPlayerViewController: RecordPlayerViewController!
        var viewModel: MockRecordPlayerViewModel!
        var mockNavigationController: MockNavigationController!
        
        beforeEach {
            
            viewModel = MockRecordPlayerViewModel()
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            recordPlayerViewController = storyboard.instantiateViewController(withIdentifier: RecordPlayerViewController.identifier) as? RecordPlayerViewController
            recordPlayerViewController.viewModel = viewModel
            mockNavigationController = MockNavigationController(rootViewController: recordPlayerViewController)
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = mockNavigationController
            window.makeKeyAndVisible()
            recordPlayerViewController.loadView()
        }
        
        describe("did load") {
            it ("Should handle mode") {
                recordPlayerViewController.viewDidLoad()
                expect(viewModel.delegate).notTo(beNil())
                expect(viewModel.didViewLoadInvoked).to(equal(true))
            }
        }
        
        describe("view Will Disappear") {
            it ("Should handle stop") {
                recordPlayerViewController.viewWillDisappear(false)
                expect(viewModel.didCallViewAboutToDisappear).to(equal(true))
            }
        }
        
        describe("did tap play/pause button") {
            it ("handle toggle button") {
                recordPlayerViewController.playPauseToggleButtonAction(UIButton())
                expect(viewModel.didHandleToggleButtonTap).to(equal(true))
            }
        }
        
        describe("show Audio Progress") {
            it ("should set slider") {
                recordPlayerViewController.showAudioProgress(progressValue: 0.5)
                expect(recordPlayerViewController.audioProgressSlider?.value).to(equal( 0.5))
            }
        }
        
        describe("starting Audio") {
            it ("should display animation") {
                recordPlayerViewController.audioPlayDidStart()
                expect(recordPlayerViewController.displayLink).toNot(beNil())
            }
        }
        
        describe("Progress update") {
            it ("should handle slider progress") {
                recordPlayerViewController.updateSliderProgress()
                expect(viewModel.didHandleSliderProgress).to(equal(true))
            }
        }
        
        describe("Did Stop Audio") {
            it ("should stop animation") {
                recordPlayerViewController.audioPlayDidStop()
                expect(recordPlayerViewController.displayLink).to(beNil())
            }
        }

    }
}
