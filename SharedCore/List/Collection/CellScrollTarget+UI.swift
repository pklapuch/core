//
//  CellScrollTarget+UI.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension CellScrollTarget {
    
    public func toUI() -> UICollectionView.ScrollPosition {
        
        switch self {
        case .top: return .top
        case .center: return .centeredVertically
        case .bottom: return .bottom
        }
    }
}
