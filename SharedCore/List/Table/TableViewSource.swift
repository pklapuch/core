//
//  TableViewSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public protocol TableViewSource: class {
    
    func registerCells(_ container: UITableView)
    
    func configureContainer(_ container: UITableView)
    
    func createCell(_ model: AnyObject, indexPath: IndexPath, container: UITableView) -> BaseTableCell?
}
