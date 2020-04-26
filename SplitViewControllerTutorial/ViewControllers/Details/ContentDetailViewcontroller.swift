//
//  ContentDetailViewcontroller.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ContentDetailViewcontroller: UIViewController {
    
    @IBOutlet private var verticalFeedTableView: VerticalFeedTableView!
    
    var stubData: [VerticalFeed] {
        FullPostViewModel.stubFullPosts.map( { VerticalFeed.userPostsFeed($0) })
    }
    
    // MARK:- Public
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalFeedTableView.setupDataSourceWith(stubData)
        updateTo(traitCollection)
        guard let indexPath = selectedIndexPath else { return }
              verticalFeedTableView?.scrollTo(indexPath)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
        navigationItem.leftBarButtonItem = traitCollection.isRegularWidthRegularHeight ? splitViewController?.displayModeButtonItem : nil
    }
}

extension ContentDetailViewcontroller: DisplayModeUpdatable {
    
    func displayModeWillChangeTo(_ displayMode: UISplitViewController.DisplayMode) {
    //    hilightsCollectionView.invalidateLayout()
    }
    
    func displayModeDidChangeTo(_ displayMode: UISplitViewController.DisplayMode) {
        
    }
}
