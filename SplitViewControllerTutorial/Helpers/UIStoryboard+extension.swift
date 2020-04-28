//
//  UIStoryboard+extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UIViewController {
    static var defaultStoryboardName: String {
        return String(describing: self)
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: defaultStoryboardName, bundle: nil)
    }
}

extension UIStoryboard {

    func instantiateViewControllerSubclass<T: UIViewController>() -> T {
        // Force casting as it would be programmer error to use this function and create a view controller from a storyboard whos initial view controller is not of this type.
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }

    func instantiateInitialViewControllerSubclass<T: UIViewController>() -> T {
        // Force casting as it would be programmer error to use this function and create a view controller from a storyboard whos initial view controller is not of this type.
        return instantiateInitialViewController() as! T
    }
}

protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {

    static func storyboardInitialViewController() -> Self {
        // Force casting as it would be programmer error to use this function and create a view controller from a storyboard whos initial view controller is not of this type.
        return Self.storyboard.instantiateInitialViewControllerSubclass()
    }

    static func instantiate(from storyboard: UIStoryboard) -> Self {
        // Force casting as it would be programmer error to use this function and create a view controller from a storyboard whos initial view controller is not of this type.
        return storyboard.instantiateViewControllerSubclass()
    }
    
    /**
     Use the ViewController Class that you want to be returned as caller.
     Use the name of the Storyboard as parameter.
     This function should be used when the Storyboard name does not match the class name of it's Initial ViewController, Ideally they should.
     **/
    static func instantiate(from storyboardName: String) -> Self {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerSubclass()
    }
}

extension UIViewController: Storyboardable { }
