//
//  TableDependency.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/10/21.
//

import Foundation

public struct TableDependency {
    
    public let dataSource: TableDataSource
    public let viewSource: TableViewSource
    public let observer: TableObserver
    
    public init(dataSource: TableDataSource, viewSource: TableViewSource, observer: TableObserver) {
        
        self.dataSource = dataSource
        self.viewSource = viewSource
        self.observer = observer
    }
}
