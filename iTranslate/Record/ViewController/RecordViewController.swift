//
//  RecordViewController.swift
//  iTranslate
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class RecordViewController: BaseViewController, RecordModelController {
    
    override var shouldHideNavigationBar: Bool {
        return true
    }
    
    var viewModel = RecordViewModel()
    let animationView = UIView(frame: CGRect(x: 200, y: 200, width: 150, height: 150))
    
    @IBOutlet weak var recordButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }
    
    func startRecordAnimation() {
        animationView.layer.cornerRadius = 75
        animationView.backgroundColor = UIColor.red
        animationView.layer.borderColor = UIColor.red.cgColor
        animationView.layer.borderWidth = 2.0
        
        view.addSubview(animationView)
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")

        scaleAnimation.duration = 0.5
        scaleAnimation.repeatCount = 30.0
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1;
        scaleAnimation.toValue = 1.2;

        animationView.layer.add(scaleAnimation, forKey: "scale")
        view.sendSubviewToBack(animationView)

        animationView.center = view.center
    }
    
    func stopRecordAnimation() {
        animationView.removeFromSuperview()
    }

    @IBAction func recordButtonAction(_ sender: UIButton) {
        viewModel.handleRecordButtonTap()
    }
    
    @IBAction func showRecordingButtonAction(_ sender: UIButton) {
        viewModel.showRecordingsButtonTapped()
    }
}

extension RecordViewController: RecordViewModelDelegate {

    func getRecordNameFromUser(completion: StringCompletion?) {
        let alertController = UIAlertController(title: "Add Record Name", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
              textField.placeholder = "Enter Name"
          }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            guard let textField = alertController.textFields?[0] else { return }
            completion?(textField.text ?? "")
          })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
            alertController.dismiss(animated: true, completion: nil)
        })
          alertController.addAction(saveAction)
          alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func showAudioPermissionAlert() {
        guard let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RecordPermissionAlertViewController.identifier) as? RecordPermissionAlertViewController else { return }
        alertView.allowCompletion = { [weak self] in
            self?.viewModel.handleAllowRecordingFromPopUp()
        }

        alertView.modalPresentationStyle = .fullScreen
        present(alertView, animated: true, completion: nil)
    }
    
    func showError(type: AlertController.Alert, error: Error?) {
        AlertController.show(type: type, error: error)
    }
    
    func showSuccessAlert(type: AlertController.Alert) {
        AlertController.show(type: type)
    }
    
    func recordingDidStart() {
        startRecordAnimation()
    }
    
    func recordingDidStop() {
        stopRecordAnimation()
    }
    
    func showRecordListingScreen() {
        guard let listViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RecordListViewController.identifier) as? RecordListViewController else { return }
        navigationController?.pushViewController(listViewController, animated: true)
    }
}
