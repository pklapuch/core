//
//  Presentable.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

/**
 Presentable represents platform specific screen controller (UIViewController, NSViewController, etc)
 Typical operations one can perform on Presentable are to push / present etc and are executed via Router
 */
public protocol Presentable: AnyObject {
    
    func toPresentable() -> AnyObject?
}


extension Presentable {
    
    public func toPresentable() -> AnyObject? { return self as AnyObject }
}
