//
//  CollectionLayoutCellSizing.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public protocol CollectionLayoutCellSizing: class {
    
    func getCellHeight(for model: NSObject) -> CGFloat?
}
