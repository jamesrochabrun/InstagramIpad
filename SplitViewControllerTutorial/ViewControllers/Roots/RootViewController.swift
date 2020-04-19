//
//  RootViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    lazy private var childContainerController: TabBarController = {
        TabBarController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(childContainerController)
        view.addSubview(childContainerController.view)
        childContainerController.view.fillSuperview()
        childContainerController.didMove(toParent: self)
    }
}

