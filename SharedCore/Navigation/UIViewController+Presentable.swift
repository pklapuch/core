//
//  UIViewController+Presentable.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension UIViewController {
    
    public var presentable: Presentable? {
        
        return self as? Presentable
    }
}
