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
    lazy var displayModeCustomButton: UIButton = {
        let button = UIButton(type: .system, image: SplitViewControllerViewModel.displayModeButtonImageFor(self.displayMode), tintColor: Instagram.tintColor(traitCollection), target: self, selector: #selector(changeDisplayMode))
        button.constrainWidth(constant: 44.0)
        button.constrainHeight(constant: 44.0)
        button.imageEdgeInsets = .init(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
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
    func togglePrefferDisplayModeExecutingCompletion(_ executing: Bool = true) {
        UIView.animate(withDuration: 0.3, animations: {
            self.preferredDisplayMode = self.displayMode == .allVisible ? .primaryHidden : .allVisible
            self.displayModeCustomButton.setImage(SplitViewControllerViewModel.displayModeButtonImageFor( self.preferredDisplayMode), for: .normal)

        }) { _ in
//            guard executing, let detailViewOnDisplayModeChange = self.detailViewController?.findLastChild(DisplayModeUpdatable.self) else { return }
//            detailViewOnDisplayModeChange.displayModeDidChangeTo(self.displayMode)
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
        if let detailViewOnDisplayModeChange = svc.detailViewController as? UINavigationController, let displayModeUpdatable = detailViewOnDisplayModeChange.topViewController as? DisplayModeUpdatable  {
            displayModeUpdatable.displayModeWillChangeTo(displayMode)
        }
    }
}

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

extension UIView {
    
    func addBorder(_ color: UIColor) {
        layer.borderWidth = 2.0
        layer.borderColor = color.cgColor
    }
}

struct SplitViewControllerViewModel {
    
    static func displayModeButtonImageFor(_ displayMode: UISplitViewController.DisplayMode) -> UIImage? {
        displayMode == .allVisible ? UIImage(named: "expand") : UIImage(named: "collapse")
    }
}
