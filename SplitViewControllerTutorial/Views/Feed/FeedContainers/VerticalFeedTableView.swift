//
//  VerticalFeedTableView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class VerticalFeedTableView: BaseXibView {
    
    @IBOutlet private var feedTableView: UITableView! {
        didSet {
            feedTableView.registerNib(FeedPostTableViewCell.self)
            feedTableView.register(NotificationListCell.self)
            feedTableView.rowHeight = UITableView.automaticDimension
            feedTableView.estimatedRowHeight = 200
            feedTableView.delegate = self
        }
    }
        
    private var dataSource: CellKindTableViewDataSource<VerticalFeed>?

    func setupDataSourceWith(_ models: [VerticalFeed]) {
        
        dataSource = CellKindTableViewDataSource(models: [models], configureCell: { (tableView, indexPath, model) -> UITableViewCell in
            switch model {
            case .userPostsFeed(let viewModel):
                let cell: FeedPostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                return cell
            case .userNotifications(let viewModel):
                let cell: NotificationListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                return cell
            }
        })
        feedTableView.dataSource = dataSource
    }
    
    // MARK:- Public
    func scrollTo(_ indexPath: IndexPath) {
        let normalizedIndexPath = IndexPath(row: indexPath.item, section: 0)
        DispatchQueue.main.async {
            self.feedTableView?.scrollToRow(at: normalizedIndexPath, at: .top, animated: false)
        }
    }
}

extension VerticalFeedTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard case VerticalFeed.userPostsFeed(_) = dataSource!.getModelAt(IndexPath(item: 0, section: section)) else { return nil }
        let header = HorizontalCollectionView()
        let headerDataModels = HilightViewModel.mockHilights.map { HorizontalContent.hilightsSnippet($0) }
        header.setupDataSourceWith(headerDataModels)
        header.setupLayoutKind(.horizontalHilightsLayout(traitCollection))
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard case VerticalFeed.userPostsFeed(_) = dataSource!.getModelAt(IndexPath(item: 0, section: section)) else { return 0 }
        return traitCollection.isRegularWidthRegularHeight ? 140.0 : 0
    }
}

enum VerticalFeed: ContentCollection {
    
    case userPostsFeed(FullPostViewModel)
    case userNotifications(NotificationListItemViewModel)
}
