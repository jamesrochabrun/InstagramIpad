//
//  CollectionReusableView.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 4/27/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class CollectionReusableView<T: UIView>: UICollectionReusableView {
    
    let subView: T = {
        T()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        addSubview(subView)
        subView.fillSuperview()
    }
}
