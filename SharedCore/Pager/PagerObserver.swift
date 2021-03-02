//
//  PagerObserver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol PagerObserver: class {
    
    func pagerDidLoad()
    
    func didShowPage(at index: Int)
}

extension PagerObserver {
    
    public func pagerDidLoad() { }
    
    public func didShowPage(at index: Int) { }
}
