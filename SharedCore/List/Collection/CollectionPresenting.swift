//
//  CollectionPresenting.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol CollectionPresenting: class {
    
    func render(sections: [CollectionSection], animated: Bool)
    
    func render(maintainContentOffsetForUpcomingContentChagnes: Bool)
    
    func render(contentSizeChangeAtIndex index: Int, animated: Bool)
    
    func renderScroll(toIndex index: Int, target: CellScrollTarget, animated: Bool)
    
    func render(scrollingEnabled: Bool)
    
    func renderVisiblePullToRefresh()
    
    func renderHiddenPullToRefresh()
}
