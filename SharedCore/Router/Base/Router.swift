//
//  Router.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public typealias AppRouting = Router & RouterWindow 

public enum PresentationMode {
    
    case fullscreen
    
    case pageSheet
}

public protocol Router {
    
    /** parent coordinator */
    var delegate: Coordinator? { get set }
    
    var presentable: Presentable { get }
        
    func push(presentable: Presentable, animated: Bool)
    
    func insert(presentable: Presentable, at index: Int)
    
    func insert(rootPresentable: Presentable)
    
    func present(presentable: Presentable, mode: PresentationMode, animated: Bool)
    
    func popToRoot(animated: Bool)
    
    func pop(animated: Bool)
    
    func pop(toPresentable presentable: Presentable, animated: Bool)
    
    func dismiss(animated: Bool)
}

