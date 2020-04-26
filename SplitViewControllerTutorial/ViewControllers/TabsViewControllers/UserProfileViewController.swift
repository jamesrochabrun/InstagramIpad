//
//  UserProfileViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {
        
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.userFeedPosts)
        updateTo(traitCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTo(traitCollection)

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
         updateTo(traitCollection)
     }
     
    private func updateTo(_ traitCollection: UITraitCollection) {
        feedCollectionView?.setupLayoutKind(.profile(traitCollection, collapsed: splitViewController?.isCollapsed ?? false))
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}

extension UserProfileViewController: GridCollectionViewDelegate {

    func cellDidSelect(_ indexPath: IndexPath) {
        
        let contentViewController = ContentDetailViewcontroller.instantiate(from: "Main")
        splitViewController?.showDetailEmbededinNavigationController(vc: contentViewController, sender: self)
        contentViewController.selectedIndexPath = indexPath
    }
}
