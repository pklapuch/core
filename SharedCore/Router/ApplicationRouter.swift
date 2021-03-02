//
//  ApplicationRouter.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit
import Combine

public class ApplicationRouter: NavigationRouter, Router {
    
    public weak var delegate: Coordinator?
    
    private var bag = CombineBag()
    
    public override init(window: UIWindow, nav: CoordinatedNavigationController) {
        
        super.init(window: window, nav: nav)
        setupNavigationEventHandler()
    }
    
    public override init(router: AppRouting, nav: CoordinatedNavigationController) {
        
        super.init(router: router, nav: nav)
        setupNavigationEventHandler()
    }
    
    private func setupNavigationEventHandler() {
        
        let handler = NavigationEventHandler()
        handler.didPop.eraseToAnyPublisher().sink { [weak self] (fromVC, toVC) in
            
            let fromString = fromVC != nil ? String(describing: fromVC!) : "--"
            let toString = toVC != nil ? String(describing: toVC!) : "--"
            
            print("pop/dismiss from \(fromString) to \(toString) event detected on \(self?.nav.identifier ?? "--") navigation controller.")
            NavigationEventConsumer.consume(from: fromVC, to: toVC, rootCoordinator: self?.delegate)
        }.store(in: &bag)
        nav.configure(handler)
    }
}

extension ApplicationRouter: RouterWindow {
    
    public func getWindow() -> AnyObject {
        
        return window
    }
    
    public func show() {
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
