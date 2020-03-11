//
//  BaseViewController.swift
//  iTranslate
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, NavigationBarOptions {
    
    var shouldHideBackButton: Bool {
        return true
    }
    
    var shouldHideNavigationBar: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationColor(color: ThemeManager.Color.navigationBlueColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleNavigationBackButton()
        
        navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: true)
    }

}
