//
//  ImageView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ImageView: BaseXibView {
    
    @IBOutlet private var imageView: UIImageView!
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}
