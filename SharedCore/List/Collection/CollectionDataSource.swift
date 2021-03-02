//
//  CollectionDataSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol CollectionDataSource: class {
    
    var collectionPresenter: CollectionPresenting? { set get }
}
