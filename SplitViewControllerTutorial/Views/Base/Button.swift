//
//  Button.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 4/28/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        tintColor = Theme.buttonTint.color
    }
}
