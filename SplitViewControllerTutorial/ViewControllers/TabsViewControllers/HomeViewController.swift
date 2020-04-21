//
//  HomeViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.homeFeedPosts.shuffled())
        updateTo(traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {
        feedCollectionView?.setupLayoutKind(.home(traitCollection))
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}

extension HomeViewController: GridCollectionViewDelegate {
    
    func cellDidSelect(_ model: PostViewModel) {
        let userProfileViewController = UserProfileViewController.instantiate(from: "Main")
        self.navigationController?.pushViewController(userProfileViewController, animated: true)
    }
}
