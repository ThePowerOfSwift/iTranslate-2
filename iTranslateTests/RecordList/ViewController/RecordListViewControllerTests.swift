//
//  RecordListViewControllerTests.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/11/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import iTranslate

class RecordListViewControllerTests: QuickSpec {
    
    override func spec() {
        var recordListViewController: RecordListViewController!
        var mockNavigationController: MockNavigationController!
        
        beforeEach {
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            recordListViewController = storyboard.instantiateViewController(withIdentifier: RecordListViewController.identifier) as? RecordListViewController
            mockNavigationController = MockNavigationController(rootViewControllr: recordListViewController)
            recordListViewController.registerCell()
        }
        
        describe("Navigation Bar") {
            it("Add Navigation Bar") {
                recordListViewController.addRightBarButton()
                expect(recordListViewController.navigationItem.rightBarButtonItem).toNot(beNil())
            }
        }
        
        describe("Records list") {
            context("when no Records") {
                beforeEach() {
                    recordListViewController?.records = []
                }
                
                it("Should show empty alert") {
                    expect(recordListViewController!.tableView?.numberOfRows(inSection: 0)).to(equal(0))
                }
            }
            
            context("when records present") {
                beforeEach() {
                    recordListViewController?.records = [RecordDisplayViewModel(name: MockData.shared.record.name, duration: MockData.shared.record.duration)]
                }
                
                it("Should show list view") {
                    expect(recordListViewController!.tableView?.numberOfRows(inSection: 0)).to(equal(1))
                }
            }
        }
        
        describe("Error") {
            it("should show error pop up") {
                recordListViewController.showError(type: .systemError, error: nil)
                expect(mockNavigationController.topViewController).toNot(beAKindOf(AlertController.self))
            }
        }
        
        describe("Records list cell") {
            beforeEach() {
                recordListViewController?.records = [RecordDisplayViewModel(name: MockData.shared.record.name, duration: MockData.shared.record.duration)]
                recordListViewController.viewModel.allRecords = [MockData.shared.record]
                recordListViewController.registerCell()
            }
            
            it("Should be configured") {
                let cell = recordListViewController?.tableView(recordListViewController!.tableView!, cellForRowAt: IndexPath(row: 0, section: 0)) as? RecordListViewCell
                expect(cell!.nameLabel!.text).to(equal(recordListViewController?.records.first!.name))
                expect(cell!.durationLabel!.text).to(contain(recordListViewController!.records.first!.duration))
            }
        }
        
        describe("Records list cell") {
            beforeEach() {
               recordListViewController?.records = [RecordDisplayViewModel(name: MockData.shared.record.name, duration: MockData.shared.record.duration)]
                recordListViewController.viewModel.allRecords = [MockData.shared.record]
            }
            
            context("on tap") {
                it("Should be audio player view") {
                    recordListViewController?.tableView(recordListViewController!.tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
                }
            }
        }
        

        describe("Should show record player") {
            it("player view controller") {
                recordListViewController.showRecordPlayer(playerViewModel: RecordPlayerViewModel(filePath: MockData.shared.recordingFilePath.absoluteString))
                expect(mockNavigationController.pushedViewController).to(beAKindOf(RecordPlayerViewController.self))
            }
        }
        
    }
    
}
