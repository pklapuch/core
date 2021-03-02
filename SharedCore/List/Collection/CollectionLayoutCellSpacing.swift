//
//  CollectionLayoutCellSpacing.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public protocol CollectionLayoutCellSpacing: class {
    
    func getTopVerticalSpacing(for model: NSObject, at indexPath: IndexPath) -> CGFloat
    
    func getBottomVerticalSpacing(for model: NSObject, at indexPath: IndexPath) -> CGFloat
}
