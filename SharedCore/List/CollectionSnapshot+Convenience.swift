//
//  CollectionSnapshot+Convenience.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public typealias CollectionSnapshot = NSDiffableDataSourceSnapshot<Int, NSObject>

extension CollectionSnapshot{
    
    public static func new<T: NSObject>(_ models: [T]) -> Self {
        
        var snapshot = CollectionSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(models)
        return snapshot
    }
}
