//
//  CellSwipeActionModel+View.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension CellSwipeActionModel.Item.ActionType {
    
    public var asStyle: UIContextualAction.Style {
        switch self {
        case .normal: return .normal
        case .destructive: return .destructive
        }
    }
}

extension CellSwipeActionModel.Item {
    
    // TODO: Move out -> back to Host app
    
    public func createContextualAction() -> UIContextualAction {
        
        let handler: UIContextualAction.Handler = { (a: UIContextualAction, v: UIView, success: (Bool) -> Void) in
            self.action()
            success(true)
        }
        
        let action = UIContextualAction(style: actionType.asStyle, title:  title, handler: handler)
        if let paintViewClassName = paintViewClassName {
            let size = CGSize.square(side: 32)
            //action.image = styles.createImage(fromPaintCodeClassName: paintViewClassName, size: size)
        }
        
        action.backgroundColor = backgroundColor ?? .clear
        
        return action
    }
}

extension CellSwipeActionModel {

    public func createSwipeConfiguration() -> UISwipeActionsConfiguration {
        
        let actions = items.map { $0.createContextualAction() }
        return UISwipeActionsConfiguration(actions: actions)
    }
}
