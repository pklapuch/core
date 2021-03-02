//
//  NavigationRouter.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public class NavigationRouter: WindowRouter, Presentable {

    internal let nav: CoordinatedNavigationController
    
    public init(window: UIWindow, nav: CoordinatedNavigationController) {
        
        self.nav = nav
        super.init(window: window)
    }
    
    init(router: AppRouting, nav: CoordinatedNavigationController) {
        
        guard let window = router.getWindow() as? UIWindow else {
            fatalError("expected UIWindow")
        }
        
        self.nav = nav
        super.init(window: window)
    }
    
    public var presentable: Presentable { return nav }
}

extension Router where Self: NavigationRouter {
    
    public func insert(presentable: Presentable, at index: Int) {
        
        if index == 0 {
            insert(rootPresentable: presentable)
        } else {
            let presentableController = presentable.toPresentable() as? UIViewController
            presentableController?.insert(on: nav, at: index)
        }
    }
    
    public func insert(rootPresentable: Presentable) {
        
        let presentableController = rootPresentable.toPresentable() as? UIViewController
        presentableController?.insert(on: nav)
    }
    
    public func present(presentable: Presentable, mode: PresentationMode, animated: Bool) {
        
        let presentableController = presentable.toPresentable() as? UIViewController
        presentableController?.modalPresentationStyle = mode.toUIType()
        presentableController?.presentationController?.delegate = nav.eventHandler
        presentableController?.present(on: nav, animated: animated, completion: nil)
    }
    
    public func popToRoot(animated: Bool) {
        
        nav.popToRootViewController(animated: animated)
    }
    
    public func push(presentable: Presentable, animated: Bool) {
        
        let vc = presentable as? UIViewController
        
        vc?.push(on: nav, animated: animated)
    }
    
    public func pop(animated: Bool) {
        
        nav.popViewController(animated: animated)
    }
    
    public func pop(toPresentable presentable: Presentable, animated: Bool) {
        
        let vc = presentable as? UIViewController
        
        vc?.pop(on: nav, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        
        weak var fromVC = nav.presentedViewController
        guard fromVC != nil else { return }
        nav.dismiss(animated: animated, completion: { [weak self] in
            
            weak var toVC = self?.nav.viewControllers.last
            self?.nav.eventHandler?.dismissViewControllerCompleted(fromVC: fromVC, toVC: toVC)
        })
    }
}

extension PresentationMode {
    
    public func toUIType() -> UIModalPresentationStyle {
    
        switch self {
        
        case .fullscreen: return .fullScreen
        case .pageSheet: return .pageSheet
        }
    }
}
