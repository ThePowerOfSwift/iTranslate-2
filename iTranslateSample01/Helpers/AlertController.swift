//
//  AlertController.swift
//  iTranslateSample01
//
//  Created by Sajeev on 3/8/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class AlertController {
    enum Alert {
        case systemError
        case empty
        
        var title: String {
            switch self {
            case .systemError: return "Error"
            case .empty: return "No Data"
            }
        }
        
        var message: String {
            switch self {
            case .systemError: return "Something went wrong. Please try again later"
            case .empty: return "There are no items to display"
            }
        }
    }
    
    static func show(type: Alert, error: Error? = nil, successHandler: VoidClosure? = nil, cancelHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: type.title, message: error?.localizedDescription ?? type.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            successHandler?()
        }
        alertController.addAction(okAction)

        DispatchQueue.main.async {
            topMostViewController().present(alertController, animated: true, completion: nil)
        }
    }
    
    class func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
}
