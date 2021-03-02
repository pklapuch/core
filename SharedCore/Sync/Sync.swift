//
//  Sync.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation

public protocol SyncDelegate: class {
    
    func didStart(sync: Sync)
    
    func didComplete(sync: Sync)
}

public protocol Sync: class {
    
    var delegate: SyncDelegate? { set get }
    
    var uuid: String { get }
    
    var name: String { get }
    
    var error: Error? { get }
    
    var hasStarted: Bool { get }
    
    var wasCancelled: Bool { get }
    
    var hasFailed: Bool { get }
    
    var hasFinished: Bool { get }
    
    func start()
    
    func cancel()
    
    func getState() -> SyncState
}

extension Sync {
    
    var startedDescription: String {
        
        return "sync started: \(name)"
    }
    
    var endedDescription: String {
        
        if wasCancelled {
            return "sync ended: \(name) - cancelled"
        } else if hasFailed {
            return "sync ended: \(name) - failed"
        } else {
            return "sync ended: \(name) - success"
        }
    }
}
