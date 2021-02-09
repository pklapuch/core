//
//  NavigationEventConsumer.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public class NavigationEventConsumer {
    
    public static func consume(from: UIViewController?, to: UIViewController?, rootCoordinator: Coordinator?) {
        
        guard let coordinators: [Coordinator] = rootCoordinator?.currentCoordinatorStack().reversed() else { return }
        
        ConditionalForEach<Coordinator>.iterate(models: coordinators) { item -> Bool in
            
            if let toNav = to as? UINavigationController {
                return item.consumeDidTransition(from: from?.presentable, to: toNav.viewControllers.last?.presentable)
            } else {
                return item.consumeDidTransition(from: from?.presentable, to: to?.presentable)
            }
        }
    }
}
