//
//  GenericView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

class GenericView<V>: BaseXibView {
    var item: V? {
        didSet {
            guard let item = item else { return }
            setupWith(item)
        }
    }
    func setupWith(_ item: V) {
    }
    
    // MARK:- To be used for protocols with self or associated type values that requires a generic constraint.
    func setupGenericItem<V>(_ item: V) {
    }
}

