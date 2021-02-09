//
//  ConditionalForEach.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public class ConditionalForEach<T> {
    
    public static func iterate<T>(models: [T], action: (T) -> Bool) {
        
        for model in models {
            if action(model) { break }
        }
    }
}
