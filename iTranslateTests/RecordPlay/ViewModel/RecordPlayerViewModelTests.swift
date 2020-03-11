//
//  RecordPlayerViewModelTests.swift
//  iTranslateTests
//
//  Created by sajeev Raj on 3/11/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
@testable import iTranslate

class RecordPlayerViewModelTests: QuickSpec {
    
    class MockRecordPlayerViewModelDelegate :RecordPlayerViewModelDelegate {
        var didAudioPlayStart = false
        var didAudioPlayStop = false
        var didShowAudioProgress = false

        func audioPlayDidStart() {
            didAudioPlayStart = true
        }
        
        func audioPlayDidStop() {
            didAudioPlayStop = true
        }
        
        func showAudioProgress(progressValue: Float) {
            didShowAudioProgress = true
        }
    }
    
    override func spec() {
        var viewModel: RecordPlayerViewModel!
        var delegate: MockRecordPlayerViewModelDelegate!
        
        beforeEach() {
            viewModel = RecordPlayerViewModel(filePath: MockData.shared.recordingFilePath.absoluteString)
            delegate = MockRecordPlayerViewModelDelegate()
            viewModel.delegate = delegate
        }
        
        describe("did load") {
            beforeEach() {
                viewModel.viewDidLoadInvoked()
            }
            
            it ("Should handle mode") {
                expect(viewModel.playMode).to(equal(.playing))
            }
        }
        
        context("Should handle mode") {
            describe("play mode") {
                beforeEach() {
                    AudioManager.shared.audioPlayer = nil
                    viewModel.playMode = .playing
                }
                
                it ("Should stop") {
                    viewModel.handleToggleButtonTap()
                    expect(delegate.didAudioPlayStop).to(equal(true))
                }
            }
            
            describe("not started mode") {
                beforeEach() {
                    AudioManager.shared.audioPlayer = nil
                    viewModel.playMode = .notStarted
                }
                
                it ("Should stop") {
                    viewModel.handleToggleButtonTap()
                    expect(delegate.didAudioPlayStart).to(equal(true))
                    expect(viewModel.playMode).to(equal(.playing))

                }
            }
            
            
            describe("paused mode") {
                beforeEach() {
                    AudioManager.shared.audioPlayer = nil
                    viewModel.playMode = .paused
                }
                
                it ("Should stop") {
                    viewModel.handleToggleButtonTap()
                    expect(delegate.didAudioPlayStart).to(equal(true))
                    expect(viewModel.playMode).to(equal(.playing))
                }
            }
        }
        
        describe("Handle dismiss view") {
            it ("Should stop player") {
                viewModel.viewAboutToDisappear()
                expect(delegate.didAudioPlayStop).to(equal(true))
            }
        }
    }
}
