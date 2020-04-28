//
//  NotificationsViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class NotificationsViewController: ViewController {
        
    @IBOutlet weak var notificationsTableView: VerticalFeedTableView!
    private var dataSource: GenericTableViewDataSource<NotificationListCell, NotificationListItemViewModel>?
    
    private var stubData: [VerticalFeed] {
        NotificationListItemViewModel.users.map { VerticalFeed.userNotifications($0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.setupDataSourceWith(stubData)
    }
}
