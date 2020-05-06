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
    
    // MARK:- UI
    lazy var displayModeCustomButton: Button = {
        let button = Button(type: .system, image: SplitViewControllerViewModel.displayModeButtonImageFor(self.displayMode), target: self, selector: #selector(togglePrefferDisplayModeExecutingCompletion))
        button.constrainWidth(constant: 44.0)
        button.constrainHeight(constant: 44.0)
        button.imageEdgeInsets = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        return button
    }()
    
    @objc private func changeDisplayMode() {
        togglePrefferDisplayModeExecutingCompletion()
    }
//
//    /**
//     Change `preferredDisplayMode` animated with a time duration of 0.25.
//     - Parameters:
//     - executing: Bool value that determines if DisplayModeUpdatable conformers should perform an update.
    //     */
    @objc func togglePrefferDisplayModeExecutingCompletion(_ executing: Bool = true) {
        UIView.animate(withDuration: 0.3, animations: {
            self.preferredDisplayMode = self.displayMode == .allVisible ? .primaryHidden : .allVisible
            self.displayModeCustomButton.setImage(SplitViewControllerViewModel.displayModeButtonImageFor(self.preferredDisplayMode), for: .normal)
            
        }) { _ in
            guard let detailViewOnDisplayModeChange = self.secondaryViewController as? UINavigationController,
                let displayModeUpdatable = detailViewOnDisplayModeChange.topViewController as? DisplayModeUpdatable
                else { return }
            displayModeUpdatable.displayModeDidChangeTo(self.displayMode)
        }
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.viewControllers = viewControllers
        preferredDisplayMode = .allVisible
        super.delegate = self
    }
    
    // MARK:- Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         displayModeButtonItem.customView = displayModeCustomButton
     }
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        guard let detailViewOnDisplayModeChange = svc.secondaryViewController as? UINavigationController, let displayModeUpdatable = detailViewOnDisplayModeChange.topViewController as? DisplayModeUpdatable else {
            return }
        displayModeUpdatable.displayModeWillChangeTo(displayMode)
    }
}

struct SplitViewControllerViewModel {
    
    static func displayModeButtonImageFor(_ displayMode: UISplitViewController.DisplayMode) -> UIImage? {
        displayMode == .allVisible ? UIImage(systemName: "arrow.up.left.and.arrow.down.right") : UIImage(systemName: "arrow.down.right.and.arrow.up.left")
    }
}
