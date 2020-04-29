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
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        }
    }
    @IBOutlet private var borderContainer: UIView!
    
    private var borderKind: BorderKind = .none
    
    override func setupWith(_ item: CircularCoverDisplayWithText) {
        titleLabel.text = item.title
        imageView.setImage(item.cover)
        updateBorderKind(item.borderKind)
    }
    
    func updateBorderKind(_ kind: BorderKind) {
        layoutIfNeeded()
        borderKind = kind
        switch kind {
        case .gradient:
            borderContainer?.setupGradient(cornerRadius: frame.size.width / 2.0, frame: frame)
            titleLabel?.textColor = Theme.secondaryText.color
        default:
            titleLabel?.textColor = Theme.primaryText.color
            borderContainer?.circle(frame)
            borderContainer.addBorder(Theme.circularBorder.color ?? .clear, width: 2.0)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard case borderKind = BorderKind.none else { return }
        borderContainer.addBorder(Theme.circularBorder.color ?? .clear, width: 2.0)
    }
    
    func reuse() {
        titleLabel?.text = ""
        imageView?.setImage(nil)
    }
}

