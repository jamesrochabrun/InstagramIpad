//
//  TabBarController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = TabBarViewModel.allCases.map { NavigationController(rootViewController: $0.masterViewController).inSplitViewControllerIfSupported(for: $0) }
    }
}

enum TabBarViewModel: String, CaseIterable {
    
    case home
    case search
    case camera
    case notifications
    case profile
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass")
        case .camera: return UIImage(systemName: "plus.app")
        case .notifications: return UIImage(systemName: "suit.heart")
        case .profile: return UIImage(systemName: "person")
        }
    }
    
    var title: String {
        rawValue
    }
    
    var masterViewController: UIViewController  {
        switch self {
        case .home: return HomeViewController.instantiate(from: "Main")
        case .search: return SearchViewController.instantiate(from: "Main")
        case .camera: return HomeViewController.instantiate(from: "Main")
        case .notifications: return NotificationsViewController.instantiate(from: "Main")
        case .profile: return UserProfileViewController.instantiate(from: "Main")
        }
    }
    
    var inSplitViewController: Bool {
        switch self {
        case .profile:
            return true
        default:
            return false
        }
    }
}

extension UINavigationController {
    
    func inSplitViewControllerIfSupported(for viewModel: TabBarViewModel) -> UIViewController {
        guard viewModel.inSplitViewController else {
            self.tabBarItem.image = viewModel.icon
            return self }
        let splitViewController = SplitViewController(viewControllers: [self, EmptyDetailViewcontroller()])
        splitViewController.tabBarItem.image = viewModel.icon
        return splitViewController
    }
}
