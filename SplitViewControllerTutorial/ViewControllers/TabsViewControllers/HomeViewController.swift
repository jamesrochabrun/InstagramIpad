//
//  HomeViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class HomeViewController: ViewController {
    
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.homeFeedPosts.shuffled())
        feedCollectionView?.setupLayoutKind(.home)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(displayNotifications))
    }
    
    @objc func displayNotifications() {
        let notificationsViewController = NotificationsViewController.instantiate(from: "Main")
        navigationController?.present(notificationsViewController, animated: true)
    }
}

extension HomeViewController: GridCollectionViewDelegate {
    
    func cellDidSelect(_ indexPath: IndexPath) {
        let userProfileViewController = UserProfileViewController.instantiate(from: "Main")
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
}

