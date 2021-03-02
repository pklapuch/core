//
//  BaseCollectionIdentifierCell.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

open class BaseCollectionIdentifierCell: UICollectionViewCell, CellReusableIdentifier {
    
    public static func registerWithCollectionViewNoNib(_ collectionView: UICollectionView) {
        
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        collectionView.register(self, forCellWithReuseIdentifier: className)
    }
    
    public static func registerWithCollectionView(_ collectionView: UICollectionView) {
        
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        let nib = UINib.init(nibName: className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
