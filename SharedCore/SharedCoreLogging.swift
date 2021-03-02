//
//  SharedCoreLogging.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/16/21.
//

import Foundation

public enum SharedCoreLogType {
    
    case debug
    
    case info
    
    case error
}

public protocol SharedCoreLogging {
    
    func scLog(message: String, type: SharedCoreLogType)
}

