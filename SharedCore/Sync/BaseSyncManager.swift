//
//  BaseSyncManager.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation

open class BaseSyncManager: Sync {
    
    public weak var delegate: SyncDelegate?
    public let uuid: String = UUID().uuidString
    public var error: Error? // reason sync failed (if failed, not cancelled)
    
    public var wasCancelled: Bool = false
    public var hasFailed: Bool = false
    
    public let queue = DispatchQueue(label: "sync_item")
    internal var started = false
    internal var finished = false
    
    public var name: String { return String(describing: self) }
    public var hasStarted: Bool { return started }
    public var hasFinished: Bool { return finished }
    
    public init() { }
    
    open func start() {
        
        queue.async { [weak self] in
            
            guard let self = self else { return }
            self.started = true
            self.delegate?.didStart(sync: self)
            self.execute()
        }
    }
    
    open func cancel() {
        
        queue.async { [weak self] in
            
            // Note: should cancel any running API tasks
            // Otherwise flow will exit on next sync operation within this sync manager
            
            guard let self = self else { return }
            
            self.wasCancelled = true
            
            if !self.started {
                
                self.started = true
                self.finish(withError: GeneralError.operationFailed)
            }
        }
    }
    
    open func execute() {
        
        /* implemented in subclass */
        fatalError()
    }
    
    public func finish(withError error: Error? = nil) {
        
        guard !hasFinished else { return } // callback already called
        guard !hasFailed else { return } // callback already called
        
        self.error = error
        self.finished = true
        
        if error != nil {
            self.hasFailed = true
        }
        
        self.delegate?.didComplete(sync: self)
    }
    
    public func getState() -> SyncState {
        
        var value: SyncState = .done
        let group = DispatchGroup()
        
        group.enter()
        
        queue.async { [weak self] in
            
            guard let self = self else {
                group.leave()
                return
            }
            
            if !self.started { value = .idle }
            if self.started && !self.finished { value = .running }
            group.leave()
        }
        
        group.wait()
        return value
    }
}
