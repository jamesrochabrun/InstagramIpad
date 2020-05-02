//
//  TabBarController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- TabBarController
final class TabBarController: UITabBarController {
    /// 1 - Set view Controllers using `TabBarViewModel`
       /// 2 - This iteration will create a master veiw controller embedded in a navigation controller for each tab.
       /// 3 - `inSplitViewControllerIfSupported` is a `UINavigationController` extension method that will embed it in a `UISplitViewController` if supported.
       /// we will see the implementation later.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = TabBarViewModel.allCases.map { NavigationController(rootViewController: $0.masterViewController).inSplitViewControllerIfSupported(for: $0) }
    }
}

// MARK:- ViewModel
enum TabBarViewModel: String, CaseIterable {
    
    case home
    case search
    case camera
    case notifications
    case profile
    
    /// Return:- the tab bar icon
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass")
        case .camera: return UIImage(systemName: "plus.app")
        case .notifications: return UIImage(systemName: "suit.heart")
        case .profile: return UIImage(systemName: "person")
        }
    }
    /// Return:- the tab bar title
    var title: String {
        rawValue
    }
    
    /// Return:-  the master/primary `topViewController`,  it instantiates a view controller using a convenient method for `UIStoryboards`.
    var masterViewController: UIViewController  {
        switch self {
        case .home: return HomeViewController.instantiate(from: "Main")
        case .search: return SearchViewController.instantiate(from: "Main")
        case .camera: return HomeViewController.instantiate(from: "Main")
        case .notifications: return NotificationsViewController.instantiate(from: "Main")
        case .profile: return UserProfileViewController.instantiate(from: "Main")
        }
    }
    /// Return:-  It defines if a tab should use a `UISplitViewController` as root or not.
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
    /**
     - parameters:
       - viewModel: The `TabBarViewModel` element.
    */
    func inSplitViewControllerIfSupported(for viewModel: TabBarViewModel) -> UIViewController {
        guard viewModel.inSplitViewController else {
            self.tabBarItem.image = viewModel.icon
            return self }
        let splitViewController = SplitViewController(viewControllers: [self, EmptyDetailViewcontroller()])
        splitViewController.tabBarItem.image = viewModel.icon
        return splitViewController
    }
}
