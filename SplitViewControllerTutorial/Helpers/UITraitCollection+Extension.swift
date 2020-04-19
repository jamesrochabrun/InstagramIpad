//
//  UITraitCollection+Extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/5/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UITraitCollection {
    
    var isRegularWidth: Bool {
        horizontalSizeClass == .regular
    }
    
    var isRegularHeight: Bool {
        verticalSizeClass == .regular
    }
    
    var isRegularWidthRegularHeight: Bool {
        isRegularWidth && isRegularHeight
    }
    
    func isDifferentToPrevious(_ previousTraitCollection: UITraitCollection?) -> Bool {
        verticalSizeClass != previousTraitCollection?.verticalSizeClass || horizontalSizeClass != previousTraitCollection?.horizontalSizeClass
    }
}
