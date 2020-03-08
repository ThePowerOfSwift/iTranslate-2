//
//  RecordViewController.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/7/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, RecordModelController {
    
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
    
    func removeRecordAnimation() {
        animationView.removeFromSuperview()
    }

    @IBAction func recordButtonAction(_ sender: UIButton) {
        viewModel.startRecording()
    }
    
    @IBAction func showRecordingButtonAction(_ sender: UIButton) {
        viewModel.showRecordList()
    }
}

extension RecordViewController: RecordViewModelDelegate {
    
    func showAudioPermissionAlert() {
        guard let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RecordPermissionAlertViewController.identifier) as? RecordPermissionAlertViewController else { return }
        alertView.allowCompletion = {
            
        }
        alertView.laterCompletion = {
            
        }
        alertView.modalPresentationStyle = .fullScreen
        present(alertView, animated: true, completion: nil)
    }
    
    func updateRecordButton(state: RecordState) {
        if state == .start {
            startRecordAnimation()
        }
        else {
            removeRecordAnimation()
        }
    }
    
    
}
