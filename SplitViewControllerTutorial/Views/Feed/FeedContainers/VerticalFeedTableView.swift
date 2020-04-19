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
            feedTableView.rowHeight = UITableView.automaticDimension
            feedTableView.estimatedRowHeight = 200
            feedTableView.delegate = self
        }
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, VerticalFeed>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, VerticalFeed>?
    
    func setupDataSourceWith(_ models: [VerticalFeed]) {
        
        dataSource = UITableViewDiffableDataSource(tableView: feedTableView) { tableView, indexPath, model in
            switch model {
            case .userPostFeed(let viewModel):
                let cell: FeedPostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                return cell
            }
        }
        feedTableView.dataSource = dataSource
      //  DispatchQueue.main.async {
            self.snapshot(models)
    //    }
    }
    
    func snapshot(_ models: [VerticalFeed]) {
        
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, VerticalFeed>()
        currentSnapshot?.appendSections([.main])
        currentSnapshot?.appendItems(models, toSection: .main)
        guard let snapShot = currentSnapshot else { return }
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}


extension VerticalFeedTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionIdentifier = currentSnapshot?.sectionIdentifiers[section].headerForSection(traitCollection)
        return sectionIdentifier
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        170.0
    }
}

enum Section {
    
    case main
    
    func headerForSection(_ traitCollection: UITraitCollection) -> UIView {
        switch self {
        case .main:
            let header = HorizontalCollectionView()
            let headerDataModels = HilightViewModel.mockHilights.map { HorizontalContent.hilightsSnippet($0) }
            header.setupDataSourceWith(headerDataModels)
            header.setupLayoutKind(.hilightsLayout(traitCollection))
            return header
        }
    }
}

enum VerticalFeed: Hashable {
    
    var id: UUID { UUID() }
    
    static func == (lhs: VerticalFeed, rhs: VerticalFeed) -> Bool {
        lhs.id == rhs.id
    }
    
    case userPostFeed(FullPostViewModel)
}

extension VerticalFeed: ContentCollection {}


//struct Section<U: Hashable, T: Hashable>: Hashable {
//    let headerItem: U
//    let items: T
//}

struct DataSource<T: Hashable> {
    let sections: [T]
}
