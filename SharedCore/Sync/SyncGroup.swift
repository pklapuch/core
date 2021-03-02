//
//  SyncGroup.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation

protocol SyncGroupDelegate: class {
    
    func didStart(group: SyncGroup, sync: Sync)
    
    func didComplete(group: SyncGroup, sync: Sync)
}

class SyncGroup: NSObject {
    
    struct State {
        
        let idleCount: Int // not running && not cancelled
        let runningCount: Int // running && not done (can be cancelled state)

        var isDone: Bool { return idleCount == 0 && runningCount == 0 }
        var isRunning: Bool { return runningCount > 0 }
    }
    
    weak var delegate: SyncGroupDelegate?
    
    private let queue: DispatchQueue
    private var idle: [Sync] // not started
    private var running = [Sync]() // started and not cancelled
    private var completed = [Sync]() // completed or cancelled ( processing stopped )
    
    private var cancelled = false
    
    let identifier: Int
    
    init(items: [Sync], delegate: SyncGroupDelegate, identifier: Int, queue: DispatchQueue) {
        
        self.idle = items
        self.delegate = delegate
        self.identifier = identifier
        self.queue = queue
        super.init()
        
        self.idle.forEach { $0.delegate = self }
    }
    
    func startNext() {
        
        guard !cancelled else { return }
        guard let sync = idle.first else { return }
        running.append(sync)
        
        idle.removeFirst()
        
        sync.start()
    }
    
    func cancel() {
        
        cancelled = true
        idle.forEach { $0.cancel() }
        running.forEach { $0.cancel() }
    }
    
    func getAllSync() -> [Sync] {
        
        return idle + running + completed
    }
    
    /** called from queue context */
    func getState() -> State {
        
        return State(idleCount: idle.count, runningCount: running.count)
    }
    
    /** called from queue context */
    private func moveToCompleted(sync: Sync) {
        
        if let index = idle.firstIndex(where: { $0.uuid == sync.uuid }) {
            
            idle.remove(at: index)
            completed.append(sync)
        }
        
        if let index = running.firstIndex(where: { $0.uuid == sync.uuid }) {
            
            running.remove(at: index)
            completed.append(sync)
        }
    }
}

extension SyncGroup: SyncDelegate {
    
    func didStart(sync: Sync) {
        
        queue.async {
            
            SharedCoreConfig.log?.scLog(message: "sync: did start item \(sync.name)", type: .debug)
            self.delegate?.didStart(group: self, sync: sync)
        }
    }
    
    func didComplete(sync: Sync) {
        
        queue.async {
            
            SharedCoreConfig.log?.scLog(message: "sync: did end item \(sync.name)", type: .debug)
            self.moveToCompleted(sync: sync)
            self.delegate?.didComplete(group: self, sync: sync)
        }
    }
}
