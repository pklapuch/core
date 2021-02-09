//
//  CoordinatorStore.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public class CoordinatorStore {
    
    public var children = [Coordinator]()
    
    public init() { }
    
    @discardableResult
    public func add(_ coordinator: Coordinator) -> Coordinator {
        
        children.append(coordinator)
        return coordinator
    }
    
    public func get(coordinatorWithClassType classType: AnyClass) -> Coordinator? {
        
        let className = NSStringFromClass(classType)
        
        for coordinator in children {
            
            let cType = type(of: coordinator)
            let cName = NSStringFromClass(cType)
            
            if className == cName { return coordinator }
        }
        
        return nil
    }
    
    public func removeAll() {
        
        children.removeAll()
    }
    
    public func remove(coordinatorWithClassType classType: AnyClass) {
        
        guard let coordinator = get(coordinatorWithClassType: classType) else { return }
        remove(coordinator)
    }
    
    public func remove(_ coordinator: Coordinator) {
        
        guard let index = children.firstIndex(where: { $0 === coordinator }) else { return }
        children.remove(at: index)
    }
}
