//
//  SyncState.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

public enum SyncState: String {
    
    case idle
    case running
    case done
}

extension SyncState {
    
    var description: String {
        
        switch self {
        
        case .idle: return "idle"
        case .running: return "running"
        case .done: return "done"
        }
    }
}
