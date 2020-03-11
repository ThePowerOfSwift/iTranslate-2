//
//  NavigationBarOptions.swift
//  iTranslate
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

protocol NavigationBarOptions {
    var shouldHideBackButton: Bool { get }
    var shouldHideNavigationBar: Bool { get }
    func handleNavigationBackButton()
    func setNavigationColor(color: UIColor)
}

extension NavigationBarOptions where Self: UIViewController {
    var shouldHideBackButton: Bool {
        return false
    }
    
    var shouldHideNavigationBar: Bool {
        return false
    }
    
    func setNavigationColor(color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func handleNavigationBackButton() {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.setHidesBackButton(shouldHideBackButton, animated: true)
    }
}
