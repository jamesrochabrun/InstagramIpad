//
//  CircularCoverWithTitleView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// used in:

/// hilights
/// Story covers with user avatar
enum BorderKind {
    case gradient
    case none
}

final class CircularCoverWithTitleView: GenericView<CircularCoverDisplayWithText> {
    
    @IBOutlet private var imageView: ImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var borderContainer: UIView!
    
    override func setupWith(_ item: CircularCoverDisplayWithText) {
        titleLabel.text = item.title
        imageView.setImage(item.cover)
        updateBorderKind(item.borderKind)
    }
    
    func updateBorderKind(_ kind: BorderKind) {
        layoutIfNeeded()
        switch kind {
        case .gradient:
            borderContainer?.setupGradient(cornerRadius: frame.size.width / 2.0, frame: frame)
        default:
            borderContainer?.circle(frame)
            borderContainer.addBorder(.white, width: 2.0)
        }
    }
    
    func reuse() {
        // todo
    }
}

