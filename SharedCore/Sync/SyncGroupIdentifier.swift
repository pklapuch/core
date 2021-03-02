//
//  SyncGroupIdentifier.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/15/21.
//

import Foundation

class SyncGroupIdentifier {
    
    private var currentValue = 0
    
    func generateNext() -> Int {
        
        let value = currentValue
        
        defer {
            
            if (!currentValue.addingReportingOverflow(1).overflow) {
                currentValue += 1
            } else {
                currentValue = 0
            }
        }
        
        return value
    }
}
