//
//  NotificationsViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class NotificationsViewController: UIViewController {
        
    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.register(NotificationListCell.self)
            usersTableView.rowHeight =  UITableView.automaticDimension
            usersTableView.estimatedRowHeight = 200
        }
    }
    private var dataSource: GenericTableViewDataSource<NotificationListCell, NotificationListItemViewModel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        updateTo(traitCollection)
    }
    
    func setupDataSource() {
        dataSource = GenericTableViewDataSource(models: [NotificationListItemViewModel.users], configureCell: { cell, model in
            cell.item = model
            return cell
        })
        usersTableView.dataSource = dataSource
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        updateTo(traitCollection)
    }
    
    private func updateTo(_ traitCollection: UITraitCollection) {
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}
