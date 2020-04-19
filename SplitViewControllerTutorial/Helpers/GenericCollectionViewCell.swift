//
//  GenericCollectionViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

 
class GenericCollectionViewCell<V>: UICollectionViewCell {
    
    var item: V? {
        didSet {
            guard let item = item else { return }
            setupWith(item)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        backgroundColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = nil
        self.setupSubviews()
    }
    
    // To be overriden. Super does not need to be called.
    func setupSubviews() {
    }
    
    // To be overriden. Super does not need to be called.
    func setupWith(_ item: V) {
    }
}
