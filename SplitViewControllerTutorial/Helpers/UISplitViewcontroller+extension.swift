//
//  UISplitViewcontroller+extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UISplitViewController {
    
    var masterViewController: UIViewController? {
        viewControllers.first
    }
    var detailViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers.last : nil
    }
    
    func showDetailEmbededinNavigationController(vc: UIViewController, sender: Any?) {
        showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
    }
    
    func isDetail(_ viewController: UIViewController) -> Bool {
        (viewController.navigationController ?? viewController) == detailViewController
    }
}
