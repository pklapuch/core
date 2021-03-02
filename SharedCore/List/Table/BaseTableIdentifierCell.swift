//
//  BaseTableIdentifierCell.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

open class BaseTableIdentifierCell: UITableViewCell, CellReusableIdentifier {

    public static func registerWithTableViewNib(_ tableView: UITableView) {
        
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        let nib = UINib.init(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public static func registerWithTableViewNoNib(_ tableView: UITableView) {
        
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        tableView.register(self, forCellReuseIdentifier: className)
    }
}
