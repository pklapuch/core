//
//  SyncManager.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation
import Combine

public class SyncManager {
    
    public static let shared = SyncManager()
    
    private let queue = DispatchQueue(label: "sync_manager")
    private var enabled = false
    
    private let identifiers = SyncGroupIdentifier()
    private let scheduled: SyncGroupManager
    private let instant: SyncGroupManager
    private var onAllActivitiesStopped: (() -> Void)?
    
    public let onStateChanged = PassthroughSubject<Void, Never>()
    public let onSyncStarted = PassthroughSubject<Sync, Never>()
    public let onSyncCompleted = PassthroughSubject<Sync, Never>()
    
    private init () {
        
        scheduled = SyncGroupManager(queue: queue, tag: "scheduled")
        instant = SyncGroupManager(queue: queue, tag: "instant")
        
        scheduled.delegate = self
        instant.delegate = self
    }
    
    public func sync(items: [Sync], syncType: SyncType) {
        
        queue.async {
        
            SharedCoreConfig.log?.scLog(message: "add \(syncType) sync: \(items.map { $0.name }.joined(separator: ", "))", type: .debug)
            
            guard self.enabled else {
                SharedCoreConfig.log?.scLog(message: "reject sync -> manager disabled", type: .debug)
                items.forEach {
                    $0.cancel()
                }
                return
            }
            
            switch syncType {
            case .scheduled:
                self.scheduled.add(items: items, identifier: self.identifiers.generateNext())
            case .instant:
                self.instant.add(items: items, identifier: self.identifiers.generateNext())
            }
            
            self.updateState()
        }
    }
    
    public func hasQueued(syncWithName name: String, block:@escaping (Bool) -> Void) {
        
        queue.async {
         
            let instantSync = self.instant.getAllSync()
            let scheduleSync = self.scheduled.getAllSync()
            let combined = instantSync + scheduleSync
            let flat = combined.flatMap { $0 }
            
            if flat.first(where: { $0.name == name && !$0.hasStarted }) != nil {
                block(true)
            } else {
                block(false)
            }
        }
    }
    
    public func enable() {
     
        enabled = true
        queue.async {
            self.updateState()
        }
    }
    
    public func isRunning(block:@escaping (Bool) -> Void) {
        
        queue.async {
            
            let instantState = self.instant.getState()
            let scheduledState = self.scheduled.getState()
            
            block(!(instantState.isDone && scheduledState.isDone))
        }
    }
    
    public func disable(block: (() -> Void)?) {
        
        queue.async {
         
            self.enabled = false
            self.onAllActivitiesStopped = block
            
            self.instant.cancel()
            self.scheduled.cancel()
            
            self.updateState()
        }
    }
    
    /** Only called from queue context */
    private func updateState() {
        
        defer { onStateChanged.send() }
        
        let instantState = instant.getState()
        let scheduledState = scheduled.getState()
        
        if instantState.isDone && scheduledState.isDone {
            
            SharedCoreConfig.log?.scLog(message: "sync manager is idle (no active or queud sync)", type: .debug)
        }
        
        if onAllActivitiesStopped != nil && instantState.isDone && scheduledState.isDone {
            
            SharedCoreConfig.log?.scLog(message: "sync manager did cancel all activities -> callback", type: .debug)
            onAllActivitiesStopped?()
            return
        }
        
        if !instantState.isDone {
            
            instant.startAll()
            return
        }
        
        if !scheduledState.isDone {
            
            scheduled.startNext()
            return
        }
    }
}

extension SyncManager: SyncGroupManagerDelegate {
    
    /** Called from queue context */
    func didStart(manager: SyncGroupManager, group: SyncGroup, sync: Sync) {
        
        SharedCoreConfig.log?.scLog(message: "sync: group (\(group.identifier)) \(sync.startedDescription)", type: .debug)
        manager.removeCompletedGroups()
        onSyncStarted.send(sync)
        updateState()
    }
    
    /** Called from queue context */
    func didComplete(manager: SyncGroupManager, group: SyncGroup, sync: Sync) {
        
        
        SharedCoreConfig.log?.scLog(message: "sync: group (\(group.identifier)) \(sync.endedDescription)", type: .debug)
        manager.removeCompletedGroups()
        onSyncCompleted.send(sync)
        updateState()
    }
}

