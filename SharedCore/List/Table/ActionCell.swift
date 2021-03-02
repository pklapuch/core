//
//  ActionCell.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol ActionCell {
    
    var leadingSwipeAction: CellSwipeActionModel? { get }
    var trailingSwipeAction: CellSwipeActionModel? { get }
}
