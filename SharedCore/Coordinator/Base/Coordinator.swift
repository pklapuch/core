//
//  Coordinator.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation
import Combine

public protocol Coordinator: AnyObject {
    
    var onCompleted: PassthroughSubject<Void, Never> { get }
    
    /**
        @brief keeps track of child coordinators
     */
    var store: CoordinatorStore { get }
    
    /**
     @brief notify coordinator that app state is ready for it to take over navigation & control
     */
    func start()
    
    /**
     @brief root router of coordinator
     */
    var router: Router & RouterWindow { get }
    
    /**
     @brief root interactor of coordinator (if any)
     */
    var rootInteractor: AnyObject? { get }
    
    /**
     @brief check if coordinator needs to react to this event or event should be passed on down the stack
     @param from - controller from which navigation started
     @param to - current top of navigation stack
     */
    func consumeDidTransition(from: Presentable?, to: Presentable?) -> Bool
    
    /**
        @brief event when controller is shown (initial controller or through navigation)
        @brief presentable - controller which appeard
     */
    func consumeDidShow(presentable: Presentable?) -> Bool
    
    /**
     @brief builds stack where [0] is root coordinator, and [n-1] is top most coordinator (or top most tier)
     @return coordinator stack
     */
    func currentCoordinatorStack() -> [Coordinator]
}

extension Coordinator {
    
    public var rootInteractor: AnyObject? { return nil }
    
    public func currentCoordinatorStack() -> [Coordinator] {
        
        var coordinators = [Coordinator]()
        coordinators.append(self)
        store.children.forEach { coordinators.append(contentsOf: $0.currentCoordinatorStack()) }
        return coordinators
    }
    
    public func consumeDidTransition(from: Presentable?, to: Presentable?) -> Bool { return false }
    public func consumeDidShow(presentable: Presentable?) -> Bool { return false }
}
