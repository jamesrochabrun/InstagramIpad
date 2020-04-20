//
//  GridCollectionView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol GridCollectionViewDelegate: AnyObject {
    func cellDidSelect(_ model: PostViewModel)
}

final class GridCollectionView: BaseXibView {
    
    static let cellSpacing: CGFloat = 4
    
    weak var delegate: GridCollectionViewDelegate?

    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PhotoPostCollectionViewCell.self)
            collectionView.register(VideoPostCollectionViewCell.self)
            collectionView.registerHeader(CollectionReusableView.self, kind: UICollectionView.elementKindSectionHeader)
        }
    }
    
 //   private var dataSource: CellKindCollectionViewDataSource<PostViewModel>?
    private var dataSource: UICollectionViewDiffableDataSource<GridSection, PostViewModel>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<GridSection, PostViewModel>?
    
    /// MARK:-  Layout
    func setupLayoutKind(_ layoutKind: GridLayoutKind) {
        collectionView.collectionViewLayout = layoutKind.layout
        configureHeader(layoutKind)
        
        currentSnapshot = NSDiffableDataSourceSnapshot<GridSection, PostViewModel>()
        currentSnapshot?.appendSections([.main])
        currentSnapshot?.appendItems(localmodels, toSection: .main)
        guard let snapShot = currentSnapshot else { return }
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
    
    /// DataSource
    private var localmodels: [PostViewModel] = []
    
    func setupDataSourceWith(_ models: [PostViewModel]) {
        
        dataSource = UICollectionViewDiffableDataSource <GridSection, PostViewModel>(collectionView: collectionView) { collectionView, indexPath, model in
            switch model.content {
            case .photo(let photoPostViewModel):
                let cell: PhotoPostCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = photoPostViewModel
                cell.delegate = self
                return cell
            case .video(let videoPostViewModel):
                let cell: VideoPostCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = videoPostViewModel
                return cell
            }
        }
        collectionView.dataSource = dataSource
        localmodels.append(contentsOf: models)
    }
    
    
    func configureHeader(_ layoutKind: GridLayoutKind) {

          dataSource?.supplementaryViewProvider = { (
              collectionView: UICollectionView,
              kind: String,
              indexPath: IndexPath) -> UICollectionReusableView? in
        
            let storiesCollectionViewHeader: CollectionReusableView = collectionView.dequeueSuplementaryView(of: UICollectionView.elementKindSectionHeader, at: indexPath)
            
            switch layoutKind {
            case .home(let traitCollection):
                let largeSnippetStoryCovers = StoryVideoCoverViewModel.storyVideoCovers.map { HorizontalContent.storySnippet($0) }
                storiesCollectionViewHeader.collectionView.setupDataSourceWith(largeSnippetStoryCovers)
                storiesCollectionViewHeader.collectionView.setupLayoutKind(.horizontalStorySnippetLayout(traitCollection))
            case .search(let traitCollection):
                let userStoryCovers = UserStoryCoverViewModel.userProfileStoryCovers.map { HorizontalContent.userStoryCircularCover($0) }
                storiesCollectionViewHeader.collectionView.setupDataSourceWith(userStoryCovers)
                storiesCollectionViewHeader.collectionView.setupLayoutKind(.horizontalStoryUserCoverLayout(traitCollection))
            default: break
            }
              return storiesCollectionViewHeader
          }
      }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.collectionViewLayout.invalidateLayout()
//    }
}

extension GridCollectionView: PhotoPostCollectionViewCellDelegate {
    
    func cellDidTapped(_ cell: PhotoPostCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let model = self.dataSource?.itemIdentifier(for: indexPath) else { return }
       // guard let model = dataSource?.getModelAt(indexPath) else { return }
         delegate?.cellDidSelect(model)
    }
}

/// diff stuff

enum GridSection {
    case main
}


/// Layout

enum GridLayoutKind {
    
    case home(UITraitCollection)
    case search(UITraitCollection)
    case profile(UITraitCollection)
    
    
    var layout: UICollectionViewLayout {
        switch self {
        case .home(_): return UICollectionViewCompositionalLayout.homeLayout()
        case .search(_): return UICollectionViewCompositionalLayout.searchLayout()
        case .profile(_): return UICollectionViewCompositionalLayout.gridLayout(3)
        }
    }
}


final class CollectionReusableView: UICollectionReusableView {
    
    let collectionView: HorizontalCollectionView = {
        HorizontalCollectionView()
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
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
}
