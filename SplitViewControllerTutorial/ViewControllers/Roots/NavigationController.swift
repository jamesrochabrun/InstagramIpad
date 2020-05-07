//
//  NavigationController.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 4/20/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.delegate = self
    }
}

extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {

    }
}
