//
//  MockNavigationController.swift
//  iTranslateTests
//
//  Created by Sajeev on 3/10/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    convenience init(rootViewControllr: UIViewController) {
        self.init(rootViewController: rootViewControllr)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.makeKeyAndVisible()
        rootViewControllr.loadView()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
    
    func getNavigationController(for viewController: UIViewController) -> MockNavigationController {
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = navigationController
        return MockNavigationController(rootViewController: viewController)
    }
}
