//
//  CellReusableIdentifier.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol CellReusableIdentifier {
    
    static var reuseIdentifier: String { get }
}

extension CellReusableIdentifier {
    
    public static var reuseIdentifier: String {
        
        return String(describing: self)
    }
}
