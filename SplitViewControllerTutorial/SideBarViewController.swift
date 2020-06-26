//
//  SideBarViewController.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 6/25/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class SideBarViewController: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"

    
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
        case list
        
        var description: String {
            switch self {
            case .list: return "List"
            }
        }
    }
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, TabBarViewModel>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        applyInitialSnapshots()
      
    }
    
    func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
    }

    
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section = NSCollectionLayoutSection.list(using: .init(appearance: .sidebar), layoutEnvironment: layoutEnvironment)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .estimated(120))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: SideBarViewController.sectionHeaderElementKind, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func configureDataSource() {
        /// 1 - header registration
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <CollectionReusableView<ProfileInfoView>>(elementKind: "Header") {
            (supplementaryView, string, indexPath) in
            supplementaryView.subView.setupWith(UserProfileViewModel.stub)
        }
        /// 2 - data source
        dataSource = UICollectionViewDiffableDataSource<Section, TabBarViewModel>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: self.configuredOutlineCell(), for: indexPath, item: item)
        }
        /// 3 - data source supplementaryViewProvider
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
    }
    
    func configuredOutlineCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, TabBarViewModel> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, TabBarViewModel> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            content.image = item.icon
            content.imageProperties.tintColor = .white
            cell.contentConfiguration = content
        //    cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func applyInitialSnapshots() {
        // set the order for our sections
        
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, TabBarViewModel>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        var outlineSnapshot = NSDiffableDataSourceSectionSnapshot<TabBarViewModel>()
        outlineSnapshot.append(TabBarViewModel.allCases)
        dataSource.apply(outlineSnapshot, to: .list, animatingDifferences: false)
    }
}

extension SideBarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tabItem = self.dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        self.splitViewController?.showDetailViewController(tabItem.masterViewController, sender: self)
    }
}

//class ItemListBaseCell<T: Hashable>: UICollectionViewListCell {
//    private var item: T? = nil
//    
//    func updateWithItem(_ newItem: T) {
//        guard item != newItem else { return }
//        item = newItem
//        setNeedsUpdateConfiguration()
//    }
//    
//    override var configurationState: UICellConfigurationState {
//        var state = super.configurationState
//        state.item = self.item as! UICellConfigurationState.T
//        return state
//    }
//}

//protocol CellConfigurable {
//    associatedtype T: Hashable
//    var item: T? { get set }
//}
//
//extension CellConfigurable {
//    var item: T? {
//        set { self[.item] = newValue }
//        get { return self[.item] as? T }
//    }
//}
// 
//extension UICellConfigurationState: CellConfigurable {
//    typealias T = <#type#>
//}
