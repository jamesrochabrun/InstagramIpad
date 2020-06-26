//
//  SplitViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol DisplayModeUpdatable {
    func displayModeWillChangeTo(_ displayMode: UISplitViewController.DisplayMode)
    func displayModeDidChangeTo(_ displayMode: UISplitViewController.DisplayMode)
}

final class SplitViewController: UISplitViewController {
    
    override init(style: UISplitViewController.Style) {
        super.init(style: style)
        preferredDisplayMode = .oneOverSecondary
        preferredSplitBehavior = .tile
        super.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
     }
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        guard let detailViewOnDisplayModeChange = svc.secondaryViewController as? UINavigationController, let displayModeUpdatable = detailViewOnDisplayModeChange.topViewController as? DisplayModeUpdatable else {
            return }
        displayModeUpdatable.displayModeWillChangeTo(displayMode)
    }
    
    /**
     - Remark: Called when App expands from `CompactWidth` to `RegularWidth` in a mulittasking enviromment.
     */
//    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
//
//    }
    
    /**
     - Remark: Called when App collapses from `RegularWidth` to `CompactWidth` in a mulittasking enviromment.
     */
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return secondaryViewController is EmptyDetailViewcontroller
    }
}
