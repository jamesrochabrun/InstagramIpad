//
//  ContentDetailViewcontroller.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ContentDetailViewcontroller: ViewController {
    
    // MARK:- Stub content
    var stubData: [VerticalFeed] {
        FullPostViewModel.stubFullPosts.map( { VerticalFeed.userPostsFeed($0) })
    }
    
    // MARK:- UI
    @IBOutlet private var verticalFeedTableView: VerticalFeedTableView!
    @IBOutlet private var tableViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var tableViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        verticalFeedTableView.setupDataSourceWith(stubData)
        verticalFeedTableView.selectionHandler = { [weak self] in
            guard let strongSelf = self else { return }
            let dummyCommentsViewController = NavigationController(rootViewController: ViewController())
           // dummyCommentsViewController.title = "Comments"
            strongSelf.navigationController?.pushViewController(dummyCommentsViewController, animated: true)
        }
    }
    
    // MARK:- UITraitCollection
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        verticalFeedTableView?.reload(animated: false)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    // MARK:- Private setup
    private func setupNavigationItems() {
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        let notificationsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(displayNotifications))
             navigationItem.rightBarButtonItem = notificationsBarButtonItem
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {

    }
    
    // MARK:- Actions
    @objc func displayNotifications() {
        let notificationsViewController = NotificationsViewController.instantiate(from: "Main")
        navigationController?.present(notificationsViewController, animated: true)
    }
}

// MARK:- DisplayModeUpdatable Protocol conformance
extension ContentDetailViewcontroller: DisplayModeUpdatable {
    
    func displayModeWillChangeTo(_ displayMode: UISplitViewController.DisplayMode) {
        
        verticalFeedTableView?.displayMode = displayMode
        let constant: CGFloat = displayMode
            != .allVisible ? 100 : 0
        tableViewTrailingConstraint?.constant = -constant
        tableViewLeadingConstraint?.constant = constant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        verticalFeedTableView?.reload(animated: true)
    }
    
    func displayModeDidChangeTo(_ displayMode: UISplitViewController.DisplayMode) {
        // Perform an action if needed
    }
}

// MARK:- UserProfileFeedSelectionDelegate Protocol conformance
extension ContentDetailViewcontroller: UserProfileFeedSelectionDelegate {
    
    func postSelectedAt(_ indexPath: IndexPath) {
        verticalFeedTableView?.scrollTo(indexPath, animated: true)
    }
}
