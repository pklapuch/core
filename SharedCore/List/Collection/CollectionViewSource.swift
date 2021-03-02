//
//  CollectionViewSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public protocol CollectionViewSource : class {
    
    func registerCells(_ container: UICollectionView)
    
    func configureContainer(_ container: UICollectionView)
    
    func createCell(_ model: NSObject, indexPath: IndexPath, container: UICollectionView) -> BaseCollectionCell?
}
