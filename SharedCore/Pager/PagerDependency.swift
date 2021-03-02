//
//  PagerDependency.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public struct PagerDependency {
    
    public let dataSource: PagerDataSource
    public let viewSource: PagerViewSource
    public let observer: PagerObserver
    
    public init(dataSource: PagerDataSource, viewSource: PagerViewSource, observer: PagerObserver) {
        
        self.dataSource = dataSource
        self.viewSource = viewSource
        self.observer = observer
    }
}
