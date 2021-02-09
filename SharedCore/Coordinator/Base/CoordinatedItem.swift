//
//  CoordinatedItem.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public class CoordinatedItem<T> {
    
    let interactor: T
    weak var presentable: Presentable?
    let events: AnyObject?
    
    public init(_ interactor: T, presentable: Presentable?, events: AnyObject? = nil) {
        
        self.interactor = interactor
        self.presentable = presentable
        self.events = events
    }
}
