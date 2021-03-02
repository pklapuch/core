//
//  PickerDependency.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/14/21.
//

import Foundation

public struct PickerDependency {
    
    public let dataSource: PickerDataSource
    public let observer: PickerObserver
    
    public init(dataSource: PickerDataSource, observer: PickerObserver) {
        
        self.dataSource = dataSource
        self.observer = observer
    }
}
