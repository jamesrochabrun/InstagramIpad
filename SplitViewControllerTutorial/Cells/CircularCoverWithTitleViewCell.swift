//
//  CircularCoverWithTitleViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit


final class CircularCoverWithTitleViewCell: GenericCollectionViewCell<CircularCoverDisplayWithText> {
    
    let userView: CircularCoverWithTitleView = {
        CircularCoverWithTitleView()
    }()
    
    var borderKind: BorderKind = .none {
        didSet {
            userView.updateBorderKind(borderKind)
        }
    }
    
    override func setupSubviews() {
        addSubview(userView)
        userView.fillSuperview()
    }

    override func setupWith(_ item: CircularCoverDisplayWithText) {
        userView.setupWith(item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userView.reuse()
    }
}

extension UIView {
    
    func addBorder(_ color: UIColor, width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
