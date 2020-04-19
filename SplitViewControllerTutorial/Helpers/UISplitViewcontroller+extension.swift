//
//  UISplitViewcontroller+extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UISplitViewController {
    
    func showDetail(_ vc: UIViewController, sender: Any) {
        showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
    }
}
