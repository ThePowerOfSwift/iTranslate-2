//
//  RecordListViewController.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class RecordListViewController: UITableViewController, RecordListModelController {
    var viewModel = RecordListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchRecords()
    }

}

extension RecordListViewController: RecordListViewModelDelegate {
    func showRecords(records: [Record]) {
        
    }
    
    func showError(type: AlertController.Alert, error: Error?) {
        AlertController.show(type: type)
    }
}

