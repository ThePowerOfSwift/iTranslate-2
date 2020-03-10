//
//  NavigationBarOptions.swift
//  iTranslate
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

protocol NavigationBarOptions {
    var shouldShowBackButton: Bool { get }
    var shouldHideNavigationBar: Bool { get }
    func handleNavigationBackButton()
    func setNavigationColor(color: UIColor)
}

extension NavigationBarOptions where Self: UIViewController {
    var shouldShowBackButton: Bool {
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
        if shouldHideNavigationBar {
            navigationController?.navigationBar.topItem?.title = " "
        }
    }
}
