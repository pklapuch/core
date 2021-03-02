//
//  SyncGroupManager.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation

protocol SyncGroupManagerDelegate: class {
    
    func didStart(manager: SyncGroupManager, group: SyncGroup, sync: Sync)
    
    func didComplete(manager: SyncGroupManager, group: SyncGroup, sync: Sync)
}

class SyncGroupManager {
        
    struct State {
        
        let idleGroups: Int
        let runningGroups: Int
        
        var isDone: Bool { return idleGroups == 0 && runningGroups == 0 }
        var isRunning: Bool { return runningGroups > 0 }
    }
    
    weak var delegate: SyncGroupManagerDelegate?

    private let queue: DispatchQueue
    private let tag: String
    private var idleGroups = [SyncGroup]()
    private var runningGroups = [SyncGroup]()
    
    init(queue: DispatchQueue, tag: String) {
        
        self.queue = queue
        self.tag = tag
    }
    
    /** Called from queue context */
    func add(items: [Sync], identifier: Int) {
        
        let group = SyncGroup(items: items, delegate: self, identifier: identifier, queue: queue)
        idleGroups.append(group)
    }
    
    /** Called from queue context */
    func getAllSync() -> [[Sync]] {
        
        let idle = idleGroups.map { $0.getAllSync() }
        let running = runningGroups.map { $0.getAllSync() }
        
        return idle + running
    }
    
    /** Called from queue context */
    func startNext() {
        
        // Trigger group that is already running but still have idle sync items
        for group in runningGroups {
            let state = group.getState()
            if state.runningCount == 0 && state.idleCount > 0 {
                group.startNext()
                return
            }
        }
    
        // Dont't start new group until current has finished
        guard runningGroups.count == 0 else { return }
        
        // Trugger idle group
        guard let group = idleGroups.first else { return }
        runningGroups.append(group)
        idleGroups.removeFirst()
        group.startNext()
    }
    
    /** Called from queue context */
    func startAll() {
        
        // Trigger groups that are already running but still have idle sync items
        for group in runningGroups {
            let state = group.getState()
            if state.runningCount == 0 && state.idleCount > 0 {
                group.startNext()
            }
        }
        
        // Trigger idle grups
        let groups = idleGroups
        runningGroups.append(contentsOf: groups)
        idleGroups.removeAll()
        groups.forEach { $0.startNext() }
    }
    
    /** Called from queue context */
    func removeCompletedGroups() {
        
        let doneIdleGroups = idleGroups.filter { $0.getState().isDone }
        doneIdleGroups.forEach {
            SharedCoreConfig.log?.scLog(message: "sync: remove \(tag) group (\($0.identifier))", type: .debug)
            if let index = idleGroups.firstIndex(of: $0) {
                idleGroups.remove(at: index)
            }
        }
        
        let doneRunningGroups = runningGroups.filter { $0.getState().isDone }
        doneRunningGroups.forEach {
            SharedCoreConfig.log?.scLog(message: "sync: remove \(tag) group (\($0.identifier))", type: .debug)
            if let index = runningGroups.firstIndex(of: $0) {
                runningGroups.remove(at: index)
            }
        }
    }
    
    /** Called from queue context */
    func cancel() {
        
        idleGroups.forEach { $0.cancel() }
        runningGroups.forEach { $0.cancel() }
        removeCompletedGroups()
    }
    
    func getState() -> State {
        
        return State(idleGroups: idleGroups.count, runningGroups: runningGroups.count)
    }
}

extension SyncGroupManager: SyncGroupDelegate {
    
    func didStart(group: SyncGroup, sync: Sync) {
        
        queue.async {
            
            self.delegate?.didStart(manager: self, group: group, sync: sync)
        }
    }
    
    func didComplete(group: SyncGroup, sync: Sync) {
        
        queue.async {
        
            if sync.hasFailed {
                group.cancel()
            }
            self.delegate?.didComplete(manager: self, group: group, sync: sync)
        }
    }
}
