//
//  RecordListViewController.swift
//  iTranslate
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
    
    private let headerHeight: CGFloat = 50.0
    private let rowHeight: CGFloat = 60.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension

        title = "Recordings"
                
        registerCell()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        addRightBarButton()
        
        setNavigationColor(color: ThemeManager.Color.navigationBlueColor)

        viewModel.fetchRecords()
    }
    
    func addRightBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        
        var barButtons = self.navigationItem.rightBarButtonItems ?? []
        barButtons.append(rightBarButton)
        navigationController?.navigationItem.rightBarButtonItems = barButtons
    }
    
    @objc func doneButtonAction() {
        navigationController?.popViewController(animated: true)
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
        viewModel.recordSelected(index: indexPath.row)
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
        headerHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }

}

extension RecordListViewController: RecordListViewModelDelegate {
    func showRecordPlayer(playerViewModel: RecordPlayerViewModel) {
        guard let playerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AudioPlayerViewController.identifier) as? AudioPlayerViewController else { return }
        playerViewController.viewModel = playerViewModel
        navigationController?.pushViewController(playerViewController, animated: true)
    }
    
    func showRecords(records: [RecordDisplayViewModel]) {
        self.records += records
    }
    
    func showError(type: AlertController.Alert, error: Error?) {
        AlertController.show(type: type)
    }
}

extension RecordListViewController: NavigationBarOptions { }

