//
//  DiffiableDataSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public typealias CollectionDiffableDataSource = UICollectionViewDiffableDataSource<Int, NSObject>

public class DiffiableDataSource: CollectionDiffableDataSource {
    
    public init(collectionView: UICollectionView, viewSource: CollectionViewSource) {
        
        super.init(collectionView: collectionView) { (collectionView,
                                                      indexPath,
                                                      model) -> UICollectionViewCell? in
            
            return viewSource.createCell(model,
                                         indexPath: indexPath,
                                         container: collectionView)
        }
    }
}
