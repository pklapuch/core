//
//  PagerDataSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol PagerDataSource: class {
    
    var pagerPresenter: PagerPresenting? { set get }
}
