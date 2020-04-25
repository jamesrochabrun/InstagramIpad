//
//  UICollectionViewLayout+Layouts.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/5/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

enum ScrollAxis {
    case vertical
    case horizontal(UICollectionLayoutSectionOrthogonalScrollingBehavior)
}

extension UICollectionViewCompositionalLayout {
    
    static func gridLayout(_ columns: Int,
                           contentInsets: UIEdgeInsets = .zero,
                           sectionInset: UIEdgeInsets = .zero,
                           scrollAxis: ScrollAxis = .vertical,
                           sectionIndexCompletion: ((Int) ->  NSCollectionLayoutBoundarySupplementaryItem?)? = nil) -> UICollectionViewLayout {
        
        /// columns must be >= 1
        return UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            /// cell size
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            /// min line spacing and the min spearator
            item.contentInsets = NSDirectionalEdgeInsets(top: contentInsets.top, leading: contentInsets.left, bottom: contentInsets.bottom, trailing: contentInsets.right)
                        
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1.0 / CGFloat(columns)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            /// sections insets
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: sectionInset.top, leading: sectionInset.left, bottom: sectionInset.bottom, trailing: sectionInset.right)
            
            switch scrollAxis {
            case .horizontal(let scrollBehaviour):
                section.orthogonalScrollingBehavior = scrollBehaviour
            case .vertical: break
            }
            
            if let suplementaryItem = sectionIndexCompletion?(sectionIndex) {
                section.boundarySupplementaryItems = [suplementaryItem]
            }
            
            return section
        }
    }
    
    static func searchLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let groupsFraction: CGFloat = 2.0 // needs to be equal of numbers of final grouped items
            let insets = NSDirectionalEdgeInsets.all(1.0)
            /// PART 1
            let firstGroup = NSCollectionLayoutGroup.mainContentTopTrailingWith(insets, fraction: groupsFraction)
            /// PART 2
            let secondGroup = NSCollectionLayoutGroup.mainContentTopLeadingWith(insets, fraction: groupsFraction)
            
            /// FINAL GROUP
            let nestedSubGroups = [firstGroup, secondGroup]
            let nestedSubGroupsCount = CGFloat(nestedSubGroups.count)
            
            let finalNestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(nestedSubGroupsCount)),
                subitems: nestedSubGroups)
            
            let section = NSCollectionLayoutSection(group: finalNestedGroup)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(180.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind:  UICollectionView.elementKindSectionHeader, alignment: .top)
            
            /// we only want to add a header on the first section
            if sectionIndex == 0 {
                section.boundarySupplementaryItems = [sectionHeader]
            }
            
            return section
            
        }
        return layout
    }
    
    static func homeLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let insets = NSDirectionalEdgeInsets.all(1.0)
            let groupsFraction: CGFloat = 5.0 // needs to be equal of numbers of final grouped items
            /// PART 1
            let firstGroup = NSCollectionLayoutGroup.mainContentTopLeadingWith(insets, fraction: groupsFraction)
            /// PART 2
            let secondGroup = NSCollectionLayoutGroup.mainContentTopTrailingWith(insets, fraction: groupsFraction)
            /// PART3
            let thirdGroup = NSCollectionLayoutGroup.mainContentBottomLeadingWith(insets, fraction: groupsFraction)
        
            let fourdGroup = NSCollectionLayoutGroup.mainContentBottomTrailingWith(insets, fraction: groupsFraction)
            
            let fifthGroup = NSCollectionLayoutGroup.mainContentVerticalRectangle(insets, fraction: groupsFraction, rectanglePosition: .bottomLeading)
            
            /// FINAL GROUP
            let nestedSubGroups = [firstGroup, secondGroup, thirdGroup, fourdGroup, fifthGroup]
            let nestedSubGroupsCount = CGFloat(nestedSubGroups.count)
            
            let finalNestedGroup = NSCollectionLayoutGroup.vertical(
             layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalWidth(nestedSubGroupsCount)),
             subitems: nestedSubGroups)
            
            let section = NSCollectionLayoutSection(group: finalNestedGroup)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(300.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind:  UICollectionView.elementKindSectionHeader, alignment: .top)
            
            /// we only want to add a header on the first section
            if sectionIndex == 0 {
                section.boundarySupplementaryItems = [sectionHeader]
            }

            return section

        }
        return layout
    }
    
    static func verticalRectanglesPerGroup() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let insets = NSDirectionalEdgeInsets.all(1.0)
            let groupsFraction = CGFloat(VerticalRectanglePosition.allCases.count)
            let nestedGroups = VerticalRectanglePosition.allCases.map { NSCollectionLayoutGroup.mainContentVerticalRectangle(insets, fraction: groupsFraction, rectanglePosition: $0) }
            let finalNestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(CGFloat(nestedGroups.count))),
                subitems: nestedGroups)
            let section = NSCollectionLayoutSection(group: finalNestedGroup)
            
            return section
            
        }
        return layout
    }
    
    static func layoutWith(width: CGFloat, itemInset: UIEdgeInsets, sectionInset: UIEdgeInsets) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            /// ideal for squares
            let itemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.absolute(width),
                                                  heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            /// min line spacing and the min spearator
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset.top, leading: itemInset.left, bottom: itemInset.bottom, trailing: itemInset.right)
    
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
            
            /// sections insets
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            
            section.contentInsets = NSDirectionalEdgeInsets(top: sectionInset.top, leading: sectionInset.left, bottom: sectionInset.bottom, trailing: sectionInset.right)
            return section
        }
    }

    static func createPagingLayoutWithScrollingBehaviour(_ scrollingBehaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> UICollectionViewLayout {

        let config = UICollectionViewCompositionalLayoutConfiguration()

        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)),
                                                                 subitem: trailingItem,
                                                                 count: 2)

            let containerGroupFractionalWidth =  CGFloat(0.85) //: CGFloat(1.0)
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
                                                  heightDimension: .fractionalHeight(0.4)),
                subitems: [leadingItem, trailingGroup])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = scrollingBehaviour
            return section

        }, configuration: config)
        return layout
    }
}

extension NSDirectionalEdgeInsets {
    
    static func all(_ value: CGFloat) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
}


extension NSCollectionLayoutGroup {
    
    /// Returns a square full width aspect ratio 1:1
    static func fullSquareGroupWith(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat) -> NSCollectionLayoutGroup {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = insets
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(CGFloat(1.0/fraction)))
        return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
    }
    
    /// Returns a Grid with a main content on the leading top area, a grid of 3 items on the bottom and a grid of to items in the trailing section
    static func mainContentTopLeadingWith(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat) -> NSCollectionLayoutGroup {
       
        // Big leading content
        let mainContentLeadingItem = NSCollectionLayoutItem.mainItem
        mainContentLeadingItem.contentInsets = insets
    
        // 2 vertical groups of 2 items each.
        let vertircalRegularItem = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItem.contentInsets = insets
        let topTrailingGroup = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItem)
        
        // Horizontal top group
        let nestedTopHorizontalGroup = NSCollectionLayoutGroup.nestedHorizontalGroup([mainContentLeadingItem, topTrailingGroup])

        ////  bottom group
        let bottomRegularItem = NSCollectionLayoutItem.horizontalRegularItem
        bottomRegularItem.contentInsets = insets
        
        // Horizontal bottom group a row of 3 items
        let horizontalBottomGroup = NSCollectionLayoutGroup.horizontal3RegularItems(bottomRegularItem)
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1/fraction)),
            subitems: [nestedTopHorizontalGroup, horizontalBottomGroup])
    }
    
    static func mainContentTopTrailingWith(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat) -> NSCollectionLayoutGroup {
        
        // Big trailing content
        let trailingBigItem = NSCollectionLayoutItem.mainItem
        trailingBigItem.contentInsets = insets
        
        // Vertical Group 2 items
        let vertircalRegularItem = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItem.contentInsets = insets
        let topLeadingGroup = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItem)
        
        // Horizontal group main content + vertical items
        let nestedTopHorizontalGroup = NSCollectionLayoutGroup.nestedHorizontalGroup([topLeadingGroup, trailingBigItem])
        
        ////  bottom Section
        let bottomRegularItem = NSCollectionLayoutItem.horizontalRegularItem
        bottomRegularItem.contentInsets = insets
        
        let horizontalBottomGroup = NSCollectionLayoutGroup.horizontal3RegularItems(bottomRegularItem)
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1/fraction)),
            subitems: [nestedTopHorizontalGroup, horizontalBottomGroup])
    }
    
    static func mainContentBottomTrailingWith(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat) -> NSCollectionLayoutGroup {
        
        ////  top  group
        let topRegularItem = NSCollectionLayoutItem.horizontalRegularItem
        topRegularItem.contentInsets = insets
        let horizontalTopGroup = NSCollectionLayoutGroup.horizontal3RegularItems(topRegularItem)
        
        // Big trailing content
        let trailingBigItem = NSCollectionLayoutItem.mainItem
        trailingBigItem.contentInsets = insets
        
        // Vertical Group 2 items
        let vertircalRegularItem = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItem.contentInsets = insets
        let topLeadingVerticalGroup = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItem)
        
        // Horizontal group main content + vertical items
        let nestedBottomHorizontalGroup = NSCollectionLayoutGroup.nestedHorizontalGroup([topLeadingVerticalGroup, trailingBigItem])
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1/fraction)),
            subitems: [horizontalTopGroup, nestedBottomHorizontalGroup])
    }
    
    static func mainContentBottomLeadingWith(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat) -> NSCollectionLayoutGroup {
        
        ////  top  group
        let topRegularItem = NSCollectionLayoutItem.horizontalRegularItem
        topRegularItem.contentInsets = insets
        let horizontalTopGroup = NSCollectionLayoutGroup.horizontal3RegularItems(topRegularItem)
        
        // Big trailing content
        let trailingBigItem = NSCollectionLayoutItem.mainItem
        trailingBigItem.contentInsets = insets
        
        // Vertical Group 2 items
        let vertircalRegularItem = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItem.contentInsets = insets
        let topTrailingVerticalGroup = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItem)
        
        // Horizontal group main content + vertical items
        let nestedBottomHorizontalGroup = NSCollectionLayoutGroup.nestedHorizontalGroup([trailingBigItem, topTrailingVerticalGroup])
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1/fraction)),
            subitems: [horizontalTopGroup, nestedBottomHorizontalGroup])
    }
    
    /// Vertical rectangular as main content
    
    static func mainContentVerticalRectangle(_ insets: NSDirectionalEdgeInsets, fraction: CGFloat, rectanglePosition: VerticalRectanglePosition) -> NSCollectionLayoutGroup {
        
        ////  top  group
        let rectangularVerticalitem = NSCollectionLayoutItem.verticalRectangularItem
        rectangularVerticalitem.contentInsets = insets
        
        // Vertical Group A items
        let vertircalRegularItemA = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItemA.contentInsets = insets
        let topVertircalRegularItemA = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItemA)
        
        // Vertical Group B items
        let vertircalRegularItemB = NSCollectionLayoutItem.verticalRegularItem
        vertircalRegularItemB.contentInsets = insets
        let topVertircalRegularItemB = NSCollectionLayoutGroup.vertical2RegularItems(vertircalRegularItemB)
        
        // Horizontal group main content + vertical items position
        var nestedMainGroupItems: [NSCollectionLayoutItem] = []
        switch rectanglePosition {
        case .bottomLeading, .topLeading:
            nestedMainGroupItems.append(contentsOf: [rectangularVerticalitem, topVertircalRegularItemA, topVertircalRegularItemB])
        case .bottomTrailing, .topTrailing:
            nestedMainGroupItems.append(contentsOf: [topVertircalRegularItemA, topVertircalRegularItemB, rectangularVerticalitem])
        }
        let nestedMainContentGroup = NSCollectionLayoutGroup.nestedHorizontalGroup(nestedMainGroupItems)
        
        /// 3 horizontal items group
        let horizontalRegularItem = NSCollectionLayoutItem.horizontalRegularItem
        horizontalRegularItem.contentInsets = insets
        let horizontalThreeItemsGroup = NSCollectionLayoutGroup.horizontal3RegularItems(horizontalRegularItem)
        
        /// Final Main group
        var group: [NSCollectionLayoutItem] = []
        switch rectanglePosition {
        case .bottomLeading, .bottomTrailing:
            group.append(contentsOf: [horizontalThreeItemsGroup, nestedMainContentGroup])
        case .topLeading, .topTrailing:
            group.append(contentsOf: [nestedMainContentGroup, horizontalThreeItemsGroup])
        }
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1/fraction)),
            subitems: group)
    }
}

enum VerticalRectanglePosition: CaseIterable {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

extension NSCollectionLayoutItem {
    
    static var mainItem: NSCollectionLayoutItem {
        NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                           heightDimension: .fractionalHeight(1.0)))
    }
    
    static var verticalRegularItem: NSCollectionLayoutItem {
         NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5)))
    }
    
    static var horizontalRegularItem: NSCollectionLayoutItem {
        NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                           heightDimension: .fractionalHeight(1.0)))
    }
    
    static var verticalRectangularItem: NSCollectionLayoutItem {
        NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1.0)))
    }
}

// Siimple groups
extension NSCollectionLayoutGroup {
    
    static func vertical2RegularItems(_ item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                           heightDimension: .fractionalHeight(1.0)),
        subitem: item, count: 2)
    }

    static func nestedHorizontalGroup(_ items: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
        NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalWidth(2/3)),
        subitems: items)
    }
    
    static func horizontal3RegularItems(_ item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .fractionalHeight(1/3)),
        subitem: item, count: 3)
    }
}
