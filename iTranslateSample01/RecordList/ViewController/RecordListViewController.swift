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
    
    var records: [RecordDisplayViewModel] = [RecordDisplayViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

        title = "Recordings"
        
        registerCell()

        viewModel.fetchRecords()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: RecordListViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecordListViewCell.identifier)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordListViewCell.identifier, for: indexPath) as? RecordListViewCell else { return UITableViewCell() }
        cell.configureView(record: records[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigation = navigationController else { return }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "RECENTLY USED"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            viewModel.removeRecord(index: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }

}

extension RecordListViewController: RecordListViewModelDelegate {
    func showRecords(records: [RecordDisplayViewModel]) {
        self.records += records
    }
    
    func showError(type: AlertController.Alert, error: Error?) {
        AlertController.show(type: type)
    }
}

