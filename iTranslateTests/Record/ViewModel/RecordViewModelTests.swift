//
//  RecordViewModelTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
@testable import iTranslate

class RecordViewModelTests: QuickSpec {
    class MockRecordView : RecordViewModelDelegate {
        var didRecordingStart = false
        var didRecordingStop = false
        var didShowError = false
        var didShowRecordListingScreen = false
        var didShowAudioPermissionAlert = false
        var didGetRecordNameFromUser = false
        
        func recordingDidStart() {
            didRecordingStart = true
        }
        
        func recordingDidStop() {
            didRecordingStop = true
        }
        
        func getRecordNameFromUser(completion: StringCompletion?) {
            didGetRecordNameFromUser = true
        }
        
        func showError(type: AlertController.Alert, error: Error?) {
            didShowError = true
        }
        
        func showRecordListingScreen() {
            didShowRecordListingScreen = true
        }
        
        func showAudioPermissionAlert() {
            didShowAudioPermissionAlert = true
        }
    }
    
    override func spec() {
        
        var recordViewModel: RecordViewModel!
        var mockRecordView: MockRecordView!
        
        beforeEach() {
            recordViewModel = RecordViewModel()
            mockRecordView = MockRecordView()
            recordViewModel.delegate = mockRecordView
        }
        
        context("Check permission status handling") {
           
            describe("at start state") {
                
                beforeEach() {
                    recordViewModel.state = .start
                }
                
                it("should change to stop state") {
                    recordViewModel.handleRecordButtonTap()
                    expect(recordViewModel.state).to(equal(.stop))
                }
            }
            
            describe("at stop state") {
                
                beforeEach() {
                    recordViewModel.state = .stop
                }
                
                it("should ask permission") {
                    recordViewModel.handleRecordButtonTap()
                    expect(mockRecordView.didShowAudioPermissionAlert).to(equal(true))
                }
            }
        }
        context("Check handle record state") {
            
            describe("at stop state") {
                
                beforeEach() {
                    recordViewModel.state = .stop
                }
                
                it("should stop recording") {
                    recordViewModel.handleRecordState()
                    expect(mockRecordView.didRecordingStop).to(equal(true))
                }
            }
            
            describe("at start state") {
                
                beforeEach() {
                    recordViewModel.state = .start
                }
                
                it("should start recording") {
                    recordViewModel.handleRecordState()
                    expect( SessionManager.shared.token).toEventually (beNil(), timeout: 30, pollInterval: 2, description: "Should show pop up")

                    expect(mockRecordView.didRecordingStart).to(equal(true))
                }
            }
        }
        
    }
}
