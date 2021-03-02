//
//  UITableView+Cell.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

extension UITableView {
    
    public func deque<T: CellReusableIdentifier>(cell: T.Type, index: IndexPath) -> T? {
        
        let identifier = cell.reuseIdentifier
        
        return dequeueReusableCell(withIdentifier: identifier, for: index) as? T
    }
}
