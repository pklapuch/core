//
//  CollectionObserver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol CollectionObserver: class {
    
    func collectionDidLoad()
    
    func didTap(index: Int)
    
    func didPullToRefresh()
    
    func didUpdateVisible(minCellIndex: CellIndex, maxCellIndex: CellIndex, offsetRatio: Double)
}

extension CollectionObserver {
    
    public func didTap(index: Int) { }
    
    public func didPullToRefresh() { }
    
    public func didUpdateVisible(minCellIndex: CellIndex, maxCellIndex: CellIndex, offsetRatio: Double) { }
}
