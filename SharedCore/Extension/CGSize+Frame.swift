//
//  CGSize+Frame.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension CGSize {
    
    public static func square(side: CGFloat) -> CGSize {
        
        return CGSize(width: side, height: side)
    }
}
