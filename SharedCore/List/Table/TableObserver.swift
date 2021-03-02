//
//  TableObserver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol TableObserver: class {
    
    func tableDidLoad()
    
    func tableDidTap(at cellIndex: CellIndex)
    
    func tableDidPullToRefresh()
}

extension TableObserver {
    
    public func tableDidLoad() { print("method not implemented") }
    
    public func tableDidTap(at cellIndex: CellIndex) { print("method not implemented") }
    
    public func tableDidPullToRefresh() { print("method not implemented") }
}
