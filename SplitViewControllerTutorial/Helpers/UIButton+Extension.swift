//
//  UIButton+Extension.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/14/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit


extension UIButton {
    
    convenience init(image: UIImage? = nil, title: String? = nil, titleColor: UIColor? = nil, titleFont: UIFont? = nil) {
        self.init()
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = titleFont
    }
    
    convenience init(type: UIButton.ButtonType, image: UIImage?, tintColor: UIColor, target: Any, selector: Selector) {
        self.init(type: type)
        setImage(image, for: .normal)
        self.tintColor = tintColor
        addTarget(target, action: selector, for: .touchUpInside)
    }
}
