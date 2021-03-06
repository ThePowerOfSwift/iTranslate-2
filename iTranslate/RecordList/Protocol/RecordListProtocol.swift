//
//  RecordListProtocol.swift
//  iTranslate
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

protocol RecordListViewModelDelegate: ViewModelDelegate {
    func showRecords(records: [RecordDisplayViewModel])
    func showRecordPlayer(playerViewModel: RecordPlayerViewModel)
    func showError(type: AlertController.Alert, error: Error?)
}

protocol RecordListModelController: ViewModelController {
    var viewModel: RecordListViewModel { get }
}

// view to viewmodel
protocol RecordListViewModelProtocol: ViewModel {
    func fetchRecords()
    func removeRecord(index: Int)
    func recordSelected(index: Int)
}
