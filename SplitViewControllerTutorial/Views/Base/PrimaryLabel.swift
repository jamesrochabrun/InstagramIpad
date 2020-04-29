//
//  PrimaryLabel.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 4/28/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class PrimaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        textColor = Theme.primaryText.color
        font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
    }
}
