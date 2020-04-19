//
//  PhotoPostCollectionViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/3/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol PhotoPostCollectionViewCellDelegate: AnyObject {
    func cellDidTapped(_ cell: PhotoPostCollectionViewCell)
}

final class PhotoPostCollectionViewCell: GenericCollectionViewCell<PhotoPostViewModel> {
    
    weak var delegate: PhotoPostCollectionViewCellDelegate?
    
    lazy var zoomImageView: ZoomImageView = {
        let imageView = ZoomImageView()
        imageView.delegate = self
        return imageView
    }()
    
    override func setupSubviews() {
         contentView.addSubview(zoomImageView)
         zoomImageView.fillSuperview()
     }
    
    override func setupWith(_ item: PhotoPostViewModel) {
        zoomImageView.setupWith(item.image)
    }
}

extension PhotoPostCollectionViewCell: ZoomImageViewDelegate {
    
    func viewDidTappped() {
        delegate?.cellDidTapped(self)
    }
}
