//
//  HorizontalCollectionView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

protocol HorizontalCollectionViewDelegate: AnyObject {
    func didSelectAt(_ indexPath: IndexPath)
}

final class HorizontalCollectionView: BaseXibView {
    
    weak var delegate: HorizontalCollectionViewDelegate?
    
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.register(CircularCoverWithTitleViewCell.self)
            collectionView.register(StoryVideoCollectionViewCell.self)
            collectionView.register(PhotoPostCollectionViewCell.self)
            collectionView.register(VideoPostCollectionViewCell.self)
        }
    }

    private var dataSource: CellKindCollectionViewDataSource<HorizontalContent>?
    
    // MARK:- Layout
    func setupLayoutKind(_ layoutKind: LayoutKind) {
        collectionView.collectionViewLayout = layoutKind.layout
    }
    
    func setupDataSourceWith(_ models: [HorizontalContent]) {
        
        dataSource = CellKindCollectionViewDataSource(models: [models], configureCell: { collectionView, indexPath, model in
            switch model {
            case .hilightsSnippet(let viewModel):
                let cell: CircularCoverWithTitleViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                return cell
            case .storySnippet(let storySnippetViewModel):
                let cell: StoryVideoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = storySnippetViewModel
                return cell
                
            case .post(let fileContent):
                switch fileContent {
                case .photo(let photoPostViewModel):
                    let cell: PhotoPostCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.item = photoPostViewModel
                    return cell
                case .video(let videoPostViewModel):
                    let cell: VideoPostCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.item = videoPostViewModel
                    return cell
                }
            case .userStoryCircularCover(let viewModel):
                let cell: CircularCoverWithTitleViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel
                return cell
            }
        })
        collectionView.dataSource = dataSource
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        invalidateLayout()
    }
    
    func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

enum HorizontalContent {
    
    case hilightsSnippet(HilightViewModel) // hilights holds an image and a title
    case storySnippet(StoryVideoCoverViewModel) // story previews
    case post(FileContent) // a post that can be a photo or an image
    case userStoryCircularCover(UserStoryCoverViewModel)
}

enum LayoutKind {
    
    case hilightsLayout(UITraitCollection)
    case storySnippetLayout(UITraitCollection)
    case horizontalPostsLayout(UITraitCollection)
    case storyUserCoverLayout(UITraitCollection)
    
    var layout: UICollectionViewLayout {
        switch self {
        case .hilightsLayout(_):
            return UICollectionViewCompositionalLayout.layoutWith(width: 120.0,
                                                                  itemInset: UIEdgeInsets(top: 10, left: 10.0, bottom: 10, right: 10.0),
                                                                  sectionInset: .zero)
        case .storySnippetLayout(_):
            return UICollectionViewCompositionalLayout.layoutWith(width: 140.0,
                                                                  itemInset: UIEdgeInsets(top: 10, left: 7.0, bottom: 10, right: 7.0),
                                                                  sectionInset: .zero)
        case .horizontalPostsLayout(_):
            return UICollectionViewCompositionalLayout.gridLayout(1, scrollAxis: .horizontal(.paging))
        case .storyUserCoverLayout(_):
            return UICollectionViewCompositionalLayout.layoutWith(width: 150.0,
                                                                  itemInset: UIEdgeInsets(top: 10, left: 12.0, bottom: 10, right: 12.0),
                                                                  sectionInset: .zero)
        }
    }
}

protocol ContentCollection {}
extension HorizontalContent: ContentCollection {}

