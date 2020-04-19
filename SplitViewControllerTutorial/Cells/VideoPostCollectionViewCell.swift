//
//  VideoPostCollectionViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class VideoPostCollectionViewCell: GenericCollectionViewCell<VideoPostViewModel> {
    
    override func setupSubviews() {
        backgroundColor = .darkGray
    }
    //
    //    override func setupWith(_ item: PhotoPostViewModel) {
    //        zoomImageView.setupWith(item.image)
    //    }
}
