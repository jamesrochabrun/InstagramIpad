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
        viewControllers = TabBarViewModel.allCases.map { childInNavigationController($0).inSplitViewControllerIfSupported(for: $0) }
    }
    
    private func childInNavigationController(_ viewModel: TabBarViewModel) -> UINavigationController {
        let navigationController = NavigationController(rootViewController: viewModel.mainContainerViewController)
        navigationController.tabBarItem.title = viewModel.title
        navigationController.tabBarItem.image = viewModel.icon
        return navigationController
    }
}

enum TabBarViewModel: String, CaseIterable {
    
    case home
    case search
    case camera
    case notifications
    case profile
    
    var icon: UIImage? {
        nil
    }
    
    var title: String {
        rawValue
    }
    
    var mainContainerViewController: UIViewController  {
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
        guard viewModel.inSplitViewController else { return self }
        return SplitViewController(viewControllers: [self, EmptyDetailViewcontroller()])
    }
}
