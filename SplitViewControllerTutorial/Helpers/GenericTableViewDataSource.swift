//
//  GenericTableViewDataSource.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/*
 Generic tableView Data Sources.
*/

final class GenericTableViewDataSource<V, T>: NSObject, UITableViewDataSource where V: GenericTableViewCell<T> {
    
    private var models: [[T]]
    private let configureCell: CellConfiguration
    typealias CellConfiguration = (V, T) -> V
    
    init(models: [[T]], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: V = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = getModelAt(indexPath)
        return configureCell(cell, model)
    }
    
    func getModelAt(_ indexPath: IndexPath) -> T {
        models[indexPath.section][indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    var numberOfItems: Int {
        models.count
    }
}

// Marker protocol to allow array homogeinity in a collection.
protocol ContentCollection {}

final class CellKindTableViewDataSource<T>: NSObject, UITableViewDataSource where T: ContentCollection {
    
    private var models: [[T]]
    private let configureCell: CellConfiguration
    typealias CellConfiguration = (UITableView, IndexPath, T) -> UITableViewCell
    
    
    init(models: [[T]], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getModelAt(indexPath)
        return configureCell(tableView, indexPath, model)
    }
    
    func getModelAt(_ indexPath: IndexPath) -> T {
        models[indexPath.section][indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    var numberOfItems: Int {
        models.count
    }
}


