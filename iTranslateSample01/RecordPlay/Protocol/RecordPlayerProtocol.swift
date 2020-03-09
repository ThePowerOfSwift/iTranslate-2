//
//  RecordPlayerProtocol.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

protocol RecordPlayerViewModelDelegate: ViewModelDelegate {
    func audioPlayDidStart()
    func audioPlayDidStop()
    func showAudioProgress(progressValue: Float)
    func showError(type: AlertController.Alert, error: Error?)
}

protocol RecordPlayerModelController: ViewModelController {
    var viewModel: RecordPlayerViewModel? { get }
}

// view to viewmodel
protocol RecordPlayerViewModelProtocol: ViewModel {
    func viewDidLoadInvoked()
    func handleSliderProgress()
    func handleToggleButtonTap()
}
