//
//  ZoomImageView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol ZoomImageViewDelegate: AnyObject {
    func viewDidTappped()
}

final class ZoomImageView: BaseXibView {
    
    weak var delegate: ZoomImageViewDelegate?
    
    @IBOutlet var postImageView: UIImageView! 
    @IBOutlet private var zoomScrollView: UIScrollView! {
        didSet {
            zoomScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        }
    }
    
    func setupWith(_ image: UIImage?) {
        postImageView?.image = image
    }
    
    @objc func viewTapped() {
        delegate?.viewDidTappped()
    }
}

