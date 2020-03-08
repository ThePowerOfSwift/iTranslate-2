//
//  RecordListViewModel.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

class RecordListViewModel: RecordListViewModelProtocol {
    
    var delegate: RecordListViewModelDelegate?
    
    var allRecords = [Record]()

    func fetchRecords() {
        let allData = Record.cached()
        allRecords = allData
        let allDisplayModels = allData.map { (record) -> RecordDisplayViewModel in
            return RecordDisplayViewModel(name: record.name, duration: record.time)
        }
        if allDisplayModels.isEmpty {
            delegate?.showError(type: .empty, error: nil)
        }
        else {
            delegate?.showRecords(records: allDisplayModels)
        }
    }
    
}
