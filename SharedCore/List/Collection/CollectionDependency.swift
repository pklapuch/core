//
//  CollectionDependency.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/11/21.
//

import Foundation

public struct CollectionDependency {
    
    public let dataSource: CollectionDataSource
    public let viewSource: CollectionViewSource
    public let observer: CollectionObserver
    
    public init(dataSource: CollectionDataSource, viewSource: CollectionViewSource, observer: CollectionObserver) {
        
        self.dataSource = dataSource
        self.viewSource = viewSource
        self.observer = observer
    }
}
