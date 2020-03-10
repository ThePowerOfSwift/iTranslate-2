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
                    expect(mockRecordView.didRecordingStop ).toEventually(equal(true), timeout: 5, pollInterval: 1, description: "Should stop")

                }
            }
            
            describe("at start state") {
                
                beforeEach() {
                    recordViewModel.state = .start
                }
                
                it("should start recording") {
                    expect(mockRecordView.didRecordingStart).toEventually(equal(true), timeout: 5, pollInterval: 1, description: "Should start")
                }
            }
        }
        
        describe("Add new record file") {
            beforeEach {
                Record.removeAll()
            }
            it("should save record") {
                recordViewModel.addNewRecord(filePath: MockData.shared.recordingFilePath, name: "test", time: "1")
                expect(Record.cached().count).toEventually(equal(1), timeout: 5, pollInterval: 1, description: "Should record and save")
            }
        }
        
        describe("Get record name") {
            it("should show pop up") {
                recordViewModel.showPopUpToAddRecordName()
                expect(mockRecordView.didGetRecordNameFromUser).to(equal(true))
            }
        }
        
        describe("Show pop up for record name") {
            it("should show pop up") {
                recordViewModel.showPopUpToAddRecordName()
                expect(mockRecordView.didGetRecordNameFromUser).to(equal(true))
            }
        }
        
        describe("Move recording path") {
            var path: URL!
            beforeEach {
                path = MockFileDataManager.directoryUrl.appendingPathComponent("temp.mp4")
                FileManager.default.createFile(atPath: path.absoluteString, contents: nil, attributes: nil)
            }
            it("should move recording to new path") {
                recordViewModel.updateAudioFilePath(temporaryPath: path){_ in }
                expect(FileManager.default.fileExists(atPath: path.absoluteString)).to(equal(false))
            }
        }
        
    }
}
