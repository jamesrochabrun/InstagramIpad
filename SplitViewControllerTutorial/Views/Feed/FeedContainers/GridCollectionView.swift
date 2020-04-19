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
        }
    }
    
    private var dataSource: CellKindCollectionViewDataSource<PostViewModel>?
    
    /// MARK:-  Layout
    func setupLayoutKind(_ layoutKind: GridLayoutKind) {
        collectionView.collectionViewLayout = layoutKind.layout
    }
    
    /// DataSource
    func setupDataSourceWith(_ models: [PostViewModel]) {
        
        dataSource = CellKindCollectionViewDataSource(models: [models], configureCell: { collectionView, indexPath, model in
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
        })
        collectionView.dataSource = dataSource
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.collectionViewLayout.invalidateLayout()
//    }
}

extension GridCollectionView: PhotoPostCollectionViewCellDelegate {
    
    func cellDidTapped(_ cell: PhotoPostCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let model = dataSource?.getModelAt(indexPath) else { return }
        delegate?.cellDidSelect(model)
    }
}

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
