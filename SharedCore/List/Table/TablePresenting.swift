//
//  TablePresenting.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol TablePresenting: class {
    
    func render(sections: [CollectionSection], animated: Bool)
    
    func batchUpdate(sections: [CollectionSection], animated: Bool)
    
    func isVisible(cellIndex: CellIndex) -> Bool
    
    func scroll(to cellIndex: CellIndex, animated: Bool)
    
    func beginUpdates()
    
    func endUpdates()
    
    // Only applicable to manually handled tableview
    
    func reloadSection(index: Int)
}
