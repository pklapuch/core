//
//  CellSwipeActionModel.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation
import UIKit

public struct CellSwipeActionModel {

    public let items: [Item]
}

extension CellSwipeActionModel {
        
    public struct Item {
        
        public let title: String?
        public let paintViewClassName: String?
        public let backgroundColor: UIColor?
        public let actionType: ActionType
        public let action: () -> Void
    }
}

extension CellSwipeActionModel.Item {
    
    public enum ActionType {
        
        case normal
        case destructive
    }
}
