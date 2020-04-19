//
//  SearchViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    lazy private var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        return search
    }()
    
    @IBOutlet private var searchFeedCollectionView: GridCollectionView!
    @IBOutlet private var userStoryCoverCollectionView: HorizontalCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchFeedCollectionView?.setupDataSourceWith(PostViewModel.searchFeedPlaceholderPosts)
        let userStoryCovers = UserStoryCoverViewModel.userProfileStoryCovers.map { HorizontalContent.userStoryCircularCover($0) }
        userStoryCoverCollectionView?.setupDataSourceWith(userStoryCovers)
        updateTo(traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {
        searchFeedCollectionView?.setupLayoutKind(.search(traitCollection))
        userStoryCoverCollectionView?.setupLayoutKind(.storyUserCoverLayout(traitCollection))
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
