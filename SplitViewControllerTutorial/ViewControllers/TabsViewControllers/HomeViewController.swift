//
//  HomeViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class HomeViewController: ViewController {
    
    // MARK:- UI
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.homeFeedPosts.shuffled())
        feedCollectionView?.setupLayoutKind(.home)
        let notificationsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(displayNotifications))
        navigationItem.rightBarButtonItem = notificationsBarButtonItem
    }

    // MARK:- Actions
    @objc func displayNotifications() {
        let notificationsViewController = NotificationsViewController.instantiate(from: "Main")
        navigationController?.present(notificationsViewController, animated: true)
    }
}

// MARK:- GridCollectionViewDelegate Conformance
extension HomeViewController: GridCollectionViewDelegate {
    
    func cellDidSelect(_ indexPath: IndexPath) {
        
        /// Pushing a split view controller.
        let userProfileViewController = UserProfileViewController.instantiate(from: "Main")
        
        let spli = SplitViewController()
        spli.preferredDisplayMode = .allVisible
        spli.viewControllers = [userProfileViewController, EmptyDetailViewcontroller()]

        let container = UIViewController()
        container.addChild(spli)
        container.view.addSubview(spli.view)
        spli.view.fillSuperview(withinSafeArea: true, padding: .zero)
        spli.didMove(toParent: self)
        
        navigationController?.pushViewController(container, animated: true)
    }
}

