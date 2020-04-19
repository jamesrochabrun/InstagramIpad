//
//  GenericTableViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

class GenericTableViewCell<V>: UITableViewCell {
    
    var item: V? {
        didSet {
            guard let item = item else { return }
            setupWith(item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
         setupSubviews()
     }
    
    // MARK:- To be overriden.
    func setupSubviews() {
        backgroundColor = nil
        selectionStyle = .none
    }
    
    func setupWith(_ item: V) {
    }
    
    // MARK:- To be used for protocols with self or associated type values that requires a generic constraint.
    func setupGenericItem<V>(_ item: V) {
    }
}
