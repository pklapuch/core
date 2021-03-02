//
//  CoordinatedItem.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public class CoordinatedItem<T> {
    
    public let interactor: T
    public weak var presentable: Presentable?
    
    public init(_ interactor: T, presentable: Presentable?) {
        
        self.interactor = interactor
        self.presentable = presentable
    }
}
