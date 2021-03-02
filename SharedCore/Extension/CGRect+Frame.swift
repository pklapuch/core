//
//  CGRect+Frame.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension CGRect {
    
    public static func square(side: CGFloat) -> CGRect {
        
        return CGRect(x: 0, y: 0, width: side, height: side)
    }
}
