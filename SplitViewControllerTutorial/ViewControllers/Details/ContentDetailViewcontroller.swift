//
//  ContentDetailViewcontroller.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ContentDetailViewcontroller: ViewController {
    
    @IBOutlet private var verticalFeedTableView: VerticalFeedTableView!
    
    var stubData: [VerticalFeed] {
        FullPostViewModel.stubFullPosts.map( { VerticalFeed.userPostsFeed($0) })
    }

    @IBOutlet weak var tableViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalFeedTableView.setupDataSourceWith(stubData)
    }
    
    private func setupNavigationItems() {
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        verticalFeedTableView?.reload(animated: false)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {

    }
}

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

extension ContentDetailViewcontroller: UserProfileFeedSelectionDelegate {
    
    func postSelectedAt(_ indexPath: IndexPath) {
        verticalFeedTableView?.scrollTo(indexPath, animated: true)
    }
}
