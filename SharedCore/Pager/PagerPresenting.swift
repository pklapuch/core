//
//  PagerPresenting.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation
 
public protocol PagerPresenting: class {
    
    func render(pages: [AnyObject], currentIndex: Int, animated: Bool)
    
    func render(pageIndex: Int, animated: Bool)
    
    func render(newPage: AnyObject, atIndex index: Int, animated: Bool)
    
    func render(replaceWithNewPage newPage: AnyObject)
    
    func render(deletedPage index: Int, currentPageIndex: Int, animated: Bool)
    
    func render(scrollEnabled: Bool)
}
