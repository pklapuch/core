//
//  CollectionLayout.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public typealias CollectionLayout = CollectionContentAwareLayout & UICollectionViewLayout

public protocol CollectionContentAwareLayout {
    
    func set(models: [NSObject])
    
    func set(lockContentOffset: Bool)
    
    func set(scrollTargetIndexPath indexPath: IndexPath?)
}

extension CollectionContentAwareLayout {
    
    public func set(scrollTargetIndexPath indexPath: IndexPath?) { }
    
    public func set(lockContentOffset: Bool) { }
}
