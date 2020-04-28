//
//  UserListCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class NotificationListCell: GenericTableViewCell<NotificationListItemViewModel> {
    
    let userView: NotificationListUserView = {
        NotificationListUserView()
    }()
    
    override func setupSubviews() {
        contentView.addSubview(userView)
        userView.fillSuperview()
    }
    
    override func setupWith(_ item: NotificationListItemViewModel) {
        userView.setupWith(item)
    }
}
