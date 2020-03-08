//
//  RecordProtocols.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

// viewmodel to view
protocol RecordViewModelDelegate: ViewModelDelegate {
    func recordingDidStart()
    func recordingDidStop()
    func showAudioPermissionAlert()
}

protocol RecordModelController: ViewModelController {
    var viewModel: RecordViewModel { get }
}

// view to viewmodel
protocol RecordViewModelProtocol: ViewModel {
    var state: RecordState { get set }
    func handleRecordButtonTap()
    func showRecordList()
}
