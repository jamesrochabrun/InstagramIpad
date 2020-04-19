//
//  HomeViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private var storiesCollectionView: HorizontalCollectionView!
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let largeSnippetStoryCovers = StoryVideoCoverViewModel.storyVideoCovers.map { HorizontalContent.storySnippet($0) }
        storiesCollectionView?.setupDataSourceWith( largeSnippetStoryCovers)
        
        feedCollectionView?.setupDataSourceWith(PostViewModel.homeFeedPosts )
        updateTo(traitCollection)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController!.navigationBar.setBackgroundImage(UIImage(named: "instagramTextLogo")!, for: .default)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.setBackgroundImage(UIImage(named: "send")!, for: .default)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {
        feedCollectionView?.setupLayoutKind(.home(traitCollection))
        storiesCollectionView?.setupLayoutKind(.storySnippetLayout(traitCollection))
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}

extension HomeViewController: GridCollectionViewDelegate {
    
    func cellDidSelect(_ model: PostViewModel) {
        
        /// Present a Profile VC
       // self.navigationController?.present(UserProfileViewController.instantiate(from: "Main"), animated: true)
        self.navigationController?.pushViewController(UserProfileViewController.instantiate(from: "Main"), animated: true)
    }
}
