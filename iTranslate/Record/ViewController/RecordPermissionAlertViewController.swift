//
//  RecordPermissionAlertViewController.swift
//  iTranslate
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> Void

class RecordPermissionAlertViewController: UIViewController {
    
    var allowCompletion: VoidClosure?

    @IBAction func allowPermissionButtonAction(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.allowCompletion?()
        }
    }
    
    @IBAction func mayBeLaterButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
