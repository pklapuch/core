//
//  CollectionSection.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public class CollectionSection {
    
    public let identifier: Int
    public let models: [NSObject]
    
    public init(identifier: Int, models: [NSObject]) {
        self.identifier = identifier
        self.models = models
    }
}
