//
//  Theme.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 4/28/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

enum Theme: String {
    
    case primaryText
    case secondaryText
    case mainBackground
    case buttonTint
    case circularBorder
    
    var color: UIColor? {
        UIColor(named: self.rawValue)
    }
}
