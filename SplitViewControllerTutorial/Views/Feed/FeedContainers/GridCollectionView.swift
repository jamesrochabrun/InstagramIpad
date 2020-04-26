//
//  GridCollectionView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol GridCollectionViewDelegate: AnyObject {
    func cellDidSelect(_ indexPath: IndexPath)
}

final class GridCollectionView: BaseXibView {
    
    static let cellSpacing: CGFloat = 4
    
    weak var delegate: GridCollectionViewDelegate?

    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PhotoPostCollectionViewCell.self)
            collectionView.register(VideoPostCollectionViewCell.self)
            collectionView.registerHeader(CollectionReusableView<HorizontalCollectionView>.self, kind: UICollectionView.elementKindSectionHeader)
            collectionView.registerHeader(CollectionReusableView<ProfileInfoView>.self, kind: UICollectionView.elementKindSectionHeader)
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<GridSection, PostViewModel>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<GridSection, PostViewModel>?
    
    private var privateModels: [PostViewModel] = []
    
    /// MARK:-  Layout
    func setupLayoutKind(_ layoutKind: GridLayoutKind) {
        collectionView.collectionViewLayout = layoutKind.layout
        configureHeader(layoutKind)
    }
    
    func setupDataSourceWith(_ models: [PostViewModel]) {
        
        privateModels.append(contentsOf: models)
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
        
        /// Snap
        currentSnapshot = NSDiffableDataSourceSnapshot<GridSection, PostViewModel>()
        currentSnapshot?.appendSections([.headerInfo, .main])
        currentSnapshot?.appendItems(models, toSection: .main)
        guard let snapShot = currentSnapshot else { return }
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapShot, animatingDifferences: true)
        }
    }
    
    func configureHeader(_ layoutKind: GridLayoutKind) {
                
        dataSource?.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            let header: CollectionReusableView<HorizontalCollectionView> = collectionView.dequeueSuplementaryView(of: UICollectionView.elementKindSectionHeader, at: indexPath)
            
            switch layoutKind {
            case .home(let traitCollection):
                guard let largeSnippetStoryCovers = layoutKind.horizontalStubContentForHeader else { return nil }
                header.subView.setupDataSourceWith(largeSnippetStoryCovers)
                header.subView.setupLayoutKind(.horizontalStorySnippetLayout(traitCollection))
            case .search(let traitCollection):
                guard let userStoryCovers = layoutKind.horizontalStubContentForHeader else { return nil }
                header.subView.setupDataSourceWith(userStoryCovers)
                header.subView.setupLayoutKind(.horizontalStoryUserCoverLayout(traitCollection))
            case .profile(let traitCollection, _):
                if indexPath.section == 0 {
                   let header: CollectionReusableView<ProfileInfoView> = collectionView.dequeueSuplementaryView(of: UICollectionView.elementKindSectionHeader, at: indexPath)
                    header.subView.setupWith(UserProfileViewModel.stub)
                    return header
                } else {
                    guard let hilights = layoutKind.horizontalStubContentForHeader else { return nil }
                    header.subView.setupDataSourceWith(hilights)
                    header.subView.setupLayoutKind(.horizontalHilightsLayout(traitCollection))
                }
            }
            return header
        }
    }
}

extension GridCollectionView: PhotoPostCollectionViewCellDelegate {
    
    func cellDidTapped(_ cell: PhotoPostCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        delegate?.cellDidSelect(indexPath)
    }
}

/// diff stuff
enum GridSection {
    case headerInfo
    case main
}
/// Layout
enum GridLayoutKind {
    
    case home(UITraitCollection)
    case search(UITraitCollection)
    case profile(UITraitCollection, collapsed: Bool = false)
    
    var layout: UICollectionViewLayout {
        switch self {
        case .home(let trait):
            return UICollectionViewCompositionalLayout.homeLayout()
           // return trait.isRegularWidthRegularHeight ? UICollectionViewCompositionalLayout.homeLayout() : UICollectionViewCompositionalLayout.gridLayout(2)
        case .search(_): return UICollectionViewCompositionalLayout.searchLayout()
        case .profile(_, let collapsed):
            
            return UICollectionViewCompositionalLayout.gridLayout(3, sectionIndexCompletion: { sectionIndex in
                let higlightsEstimatedHeight: CGFloat = collapsed ?  110.0 : 0.1
                let estimatedHeight: CGFloat = sectionIndex == 0 ? 350.0 : higlightsEstimatedHeight
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .estimated(estimatedHeight))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind:  UICollectionView.elementKindSectionHeader, alignment: .top)
//                guard sectionIndex == 0  else {
//                    return collapsed ? sectionHeader : nil
//                }
                return sectionHeader
            })
        }
    }
    
    var horizontalStubContentForHeader: [HorizontalContent]? {
        switch self {
        case .home(_): return StoryVideoCoverViewModel.storyVideoCovers.map { HorizontalContent.storySnippet($0) }
        case .search(_): return UserStoryCoverViewModel.userProfileStoryCovers.map { HorizontalContent.userStoryCircularCover($0) }
        case .profile(_): return HilightViewModel.mockHilights.map { HorizontalContent.hilightsSnippet($0) }
        }
    }
}

final class CollectionReusableView<T: UIView>: UICollectionReusableView {
    
    let subView: T = {
        T()
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
        addSubview(subView)
        subView.fillSuperview()
    }
}
