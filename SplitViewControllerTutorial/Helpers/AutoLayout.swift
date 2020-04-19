//
//  AutoLayout.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperview(withinSafeArea: Bool = false, padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        
        let superviewTopAnchor = withinSafeArea ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor
        let superviewLeadingAnchor = withinSafeArea ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor
        let superviewTrailingAnchor = withinSafeArea ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor
        let superviewBottomAnchor = withinSafeArea ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor

        // Apple Doc: Typically, using this method is more efficient than activating each constraint individually.
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom)
        ])
        
    }
    
    func centerInSuperview(width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        } else if let h = height {
            heightAnchor.constraint(equalTo: h).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        } else if let w = width {
            widthAnchor.constraint(equalTo: w).isActive = true
        }
    }
    
    func anchorSize(to view: UIView, multiplier: CGFloat = 1.0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
