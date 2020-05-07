//
//  VerticalFeedTableView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- UI
final class VerticalFeedTableView: BaseXibView {
    
    @IBOutlet private var feedTableView: UITableView! {
        didSet {
            feedTableView.registerNib(FeedPostTableViewCell.self)
            feedTableView.register(NotificationListCell.self)
            feedTableView.rowHeight = UITableView.automaticDimension
            feedTableView.estimatedRowHeight = 200
            feedTableView.delegate = self
            feedTableView.separatorStyle = .none
            feedTableView.showsVerticalScrollIndicator = false
        }
    }
    
    // MARK:- Private
    private var dataSource: CellKindTableViewDataSource<VerticalFeed>?
    
    // MARK:- Public
    var displayMode: UISplitViewController.DisplayMode = .allVisible
    var selectionHandler: (() -> Void)?

    func setupDataSourceWith(_ models: [VerticalFeed]) {
        
        dataSource = CellKindTableViewDataSource(models: [models], configureCell: { (tableView, indexPath, model) -> UITableViewCell in
            switch model {
            case .userPostsFeed(let viewModel):
                let cell: FeedPostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                cell.delegate = self
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
    func scrollTo(_ indexPath: IndexPath, animated: Bool = false) {
        let normalizedIndexPath = IndexPath(row: indexPath.item, section: 0)
        DispatchQueue.main.async {
            self.feedTableView?.scrollToRow(at: normalizedIndexPath, at: .top, animated: animated)
        }
    }
    
    func reload(animated: Bool, duration: TimeInterval = 0.3) {
        guard animated else {
            feedTableView?.reloadData()
            return
        }
        UIView.transition(with: feedTableView,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { self.feedTableView.reloadData() })
    }
}

// MARK:- Layout
extension VerticalFeedTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = dataSource,
        case VerticalFeed.userPostsFeed(_) = dataSource.getModelAt(IndexPath(item: 0, section: section)) else { return nil }
        let header = HorizontalCollectionView()
        let headerDataModels = HilightViewModel.mockHilights.map { HorizontalContent.hilightsSnippet($0) }
        header.setupDataSourceWith(headerDataModels)
        header.setupLayoutKind(.horizontalHilightsLayout)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let dataSource = dataSource,
        case VerticalFeed.userPostsFeed(_) = dataSource.getModelAt(IndexPath(item: 0, section: section)) else { return 0 }
        return displayMode != .allVisible ? 140.0 : 0
    }
}

extension VerticalFeedTableView: FeedPostTableViewCellDelegate {
    
    func viewAllCommentsDidTapped() {
        selectionHandler?()
    }
}

// MARK:- DataSource
enum VerticalFeed: ContentCollection {
    
    case userPostsFeed(FullPostViewModel)
    case userNotifications(NotificationListItemViewModel)
}
