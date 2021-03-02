//
//  CoordinatedNavigationController.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public class CoordinatedNavigationController: UINavigationController, Presentable {
    
    public var identifier: String?
    private(set) var eventHandler: NavigationEventHandler?
    
    public func configure(_ eventHandler: NavigationEventHandler) {
        
        delegate = eventHandler
        self.eventHandler = eventHandler
    }
}
