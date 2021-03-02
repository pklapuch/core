//
//  CellHighlightAnimation.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/10/21.
//

import UIKit

public class CellHighlightAnimation {
    
    weak var view: UIView?
    weak var bgView: UIView?
    
    public init(view: UIView, bgView: UIView?) {
        
        self.view = view
        self.bgView = bgView
    }
    
    public func hidhlightDidChange(_ isHighlighted: Bool) {
        
        let duration = isHighlighted ? 0.35 : 0.3
        let transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : CGAffineTransform.identity
        let bgColor = isHighlighted ? UIColor(white: 1.0, alpha: 0.2) : UIColor(white: 1.0, alpha: 0.1)
        
        let animations = { [weak self] in
            
            self?.view?.transform = transform
            self?.bgView?.backgroundColor = bgColor
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: animations,
                       completion: nil)
    }
}
