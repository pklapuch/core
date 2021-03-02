//
//  UINavigationController+Push.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension UIViewController {
    
    public func push(on nav: UINavigationController, animated: Bool) {
        
        nav.pushViewController(self, animated: animated)
    }
    
    public func present(on nav: UINavigationController, animated: Bool, completion: (() -> Void)? = nil) {
        
        nav.present(self, animated: animated, completion: completion)
    }
    
    public func pop(on nav: UINavigationController, animated: Bool) {
        
        nav.popToViewController(self, animated: animated)
    }
    
    public func insert(on nav: UINavigationController, at index: Int) {
        
        if nav.viewControllers.count <= index {
            nav.viewControllers.append(self)
        } else {
            nav.viewControllers.insert(self, at: index)
        }
    }
    
    public func insert(on nav: UINavigationController) {
        
        nav.viewControllers.insert(self, at: 0)
    }
}
