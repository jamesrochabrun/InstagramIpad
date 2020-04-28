//
//  GenericCollectionViewDataSource.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/*
 Generic collectionView Data Sources.
*/

final class GenericCollectionViewDataSource<V, T>: NSObject, UICollectionViewDataSource where V: UICollectionViewCell {
    
    private var models: [[T]]
    private let configureCell: CellConfiguration
    typealias CellConfiguration = (V, T) -> V
    
    init(models: [[T]], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: V = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let model = getModelAt(indexPath)
        return configureCell(cell, model)
    }
    
    func getModelAt(_ indexPath: IndexPath) -> T {
        models[indexPath.section][indexPath.item]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        models.count
    }
    
    var numberOfItems: Int {
        models.count
    }
}

final class CellKindCollectionViewDataSource<T>: NSObject, UICollectionViewDataSource where T: ContentCollection {
    
    private var models: [[T]]
    
    private let configureCell: CellConfiguration
    typealias CellConfiguration = (UICollectionView, IndexPath, T) -> UICollectionViewCell
    
    init(models: [[T]], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = getModelAt(indexPath)
        return configureCell(collectionView, indexPath, model)
    }
    
    func getModelAt(_ indexPath: IndexPath) -> T {
        models[indexPath.section][indexPath.item]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        models.count
    }
    
    var numberOfItems: Int {
        models.count
    }
}
