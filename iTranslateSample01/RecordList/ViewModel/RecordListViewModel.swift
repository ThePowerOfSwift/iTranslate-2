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

    func fetchRecords() {
        let allRecords = Record.cached()
        if allRecords.isEmpty {
            delegate?.showError(type: .empty, error: nil)
        }
        else {
            delegate?.showRecords(records: allRecords)
        }
    }
    
}
