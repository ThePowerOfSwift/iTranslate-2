//
//  RecordListViewModelTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
@testable import iTranslate

class RecordListViewModelTests: QuickSpec {
    class MockRecordListView : RecordListViewModelDelegate {
        var records = [RecordDisplayViewModel]()
        var recordViewModel: RecordPlayerViewModel?
        var didShowError = false
        
        func showRecords(records: [RecordDisplayViewModel]) {
            self.records = records
        }
        
        func showRecordPlayer(playerViewModel: RecordPlayerViewModel) {
            recordViewModel = playerViewModel
        }
        
        func showError(type: AlertController.Alert, error: Error?) {
            didShowError = true
        }
    }
    
    override func spec() {
        
        var recordListViewModel: RecordListViewModel!
        var mockRecordListView: MockRecordListView!
        
        beforeEach() {
            recordListViewModel = RecordListViewModel()
            mockRecordListView = MockRecordListView()
            recordListViewModel.delegate = mockRecordListView
        }
        
        
        context("Fetch records") {
            describe("if empty cache") {
                beforeEach() {
                    Record.removeAll()
                }
                it("should display error pop up") {
                    recordListViewModel.fetchRecords()
                    expect(mockRecordListView.didShowError).to(equal(true))
                }
            }
            
            describe("if non empty cache") {
                beforeEach() {
                    MockData.shared.record.save()
                }
                
                it("should show records") {
                    recordListViewModel.fetchRecords()
                    sleep(2)
                    expect(mockRecordListView.records.count).notTo(equal(0))
                }
            }
        }
        
        describe("Select record") {
            beforeEach() {
                sleep(2)

                MockData.shared.record.save()
                recordListViewModel.allRecords = [MockData.shared.record]
            }
            
            it("at specific index") {
                recordListViewModel.recordSelected(index: 0 )
                expect(mockRecordListView.recordViewModel).toNot(beNil())
            }
        }
    }
}
