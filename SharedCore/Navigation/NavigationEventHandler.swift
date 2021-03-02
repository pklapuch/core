//
//  NavigationEventHandler.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit
import Combine

public class NavigationEventHandler: NSObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    public let didShow = PassthroughSubject<UIViewController, Never>()
    public let didPop = PassthroughSubject<(UIViewController?, UIViewController?), Never>()
    
    public override init() {
        super.init()
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
        let transitionCoord = navigationController.transitionCoordinator
        if let isCancelled = transitionCoord?.isCancelled, isCancelled { return }
        
        didShow.send(viewController)
        
        let fromViewController = transitionCoord?.viewController(forKey: .from)
        let toViewController = transitionCoord?.viewController(forKey: .to)
        
        // At least one must exist
        guard (fromViewController != nil || toViewController != nil) else { return }
        
        // Pushed ?
        if let fromViewController = fromViewController {
            if navigationController.viewControllers.contains(fromViewController) {
                return
            }
        }
        
        if let from = fromViewController, let to = toViewController {
            //log.debug("did pop from: \(from) to \(to)")
        } else if let from = fromViewController {
            //log.debug("did pop from: \(from) ")
        } else if let to = toViewController {
            //log.debug("did pop to: \(to) ")
        }
        
        didPop.send((fromViewController, toViewController))
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        let presenting = presentationController.presentingViewController
        let presented = presentationController.presentedViewController
        
        didPop.send((presented, presenting))
    }
    
    public func dismissViewControllerCompleted(fromVC from: UIViewController?, toVC to: UIViewController?) {
        
        didPop.send((from, to))
    }
}
