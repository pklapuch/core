//
//  UICollectionView+Cell.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/10/21.
//

import UIKit

extension UICollectionView {
    
    public func deque<T: CellReusableIdentifier>(cell: T.Type, index: IndexPath) -> T? {
        
        let identifier = cell.reuseIdentifier
        return dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? T
    }
}
