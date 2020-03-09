//
//  RecordProtocols.swift
//  iTranslate
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

typealias StringCompletion = (String) -> ()

// viewmodel to view
protocol RecordViewModelDelegate: ViewModelDelegate {
    func recordingDidStart()
    func recordingDidStop()
    func getRecordNameFromUser(completion: StringCompletion?)
    func showError(type: AlertController.Alert, error: Error?)
    func showRecordListingScreen()
    func showAudioPermissionAlert()
}

protocol RecordModelController: ViewModelController {
    var viewModel: RecordViewModel { get }
}

// view to viewmodel
protocol RecordViewModelProtocol: ViewModel {
    var state: RecordState { get set }
    func handleRecordButtonTap()
    func handleAllowRecordingFromPopUp()
    func showRecordingsButtonTapped()
}
