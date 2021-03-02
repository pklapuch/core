//
//  TableDataSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol TableDataSource: class {
    
    var tablePresenter: TablePresenting? { set get }
}
