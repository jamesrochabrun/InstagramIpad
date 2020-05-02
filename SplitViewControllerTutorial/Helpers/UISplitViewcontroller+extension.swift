//
//  UISplitViewcontroller+extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UISplitViewController {
    
    /// Return:- The master view controller.
    var primaryViewController: UIViewController? {
        viewControllers.first
    }
    /// Return:- The detail view controller.
    var secondaryViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers.last : nil
    }
    
    /// Convenience wrapper to display the detail embedded in a navigation controller.
    func showDetailEmbededinNavigationController(vc: UIViewController, sender: Any?) {
        showDetailViewController(NavigationController(rootViewController: vc), sender: sender)
    }
    
    /// Convenience method to detect if a view controller is a detail, this helps to detect pushes in navigation stack if needed.
    func isDetail(_ viewController: UIViewController) -> Bool {
        (viewController.navigationController ?? viewController) == secondaryViewController
    }
}
