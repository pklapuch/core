//
//  DefaultTableViewDelegate.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit
import Combine

public protocol TableViewCellActionDelegate: class {
    
    func getLeadingAction(atIndexPath indexPath: IndexPath) -> CellSwipeActionModel?
    
    func getTrailingAction(atIndexPath indexPath: IndexPath) -> CellSwipeActionModel?
    
    func canEdit(atIndexPath indexPath: IndexPath) -> Bool
}

public class DefaultTableViewDelegate: NSObject, UITableViewDelegate {
    
    public weak var delegate: TableViewCellActionDelegate?
    public let onDidSelectRow = PassthroughSubject<CellIndex, Never>()
    public let onWillDisplayCell = PassthroughSubject<UITableViewCell, Never>()
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onDidSelectRow.send(CellIndex(section: indexPath.section, row: indexPath.row))
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onWillDisplayCell.send(cell)
    }
    
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        guard let action = delegate?.getLeadingAction(atIndexPath: indexPath) else { return nil }
        
        return action.createSwipeConfiguration()
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let action = delegate?.getTrailingAction(atIndexPath: indexPath) else { return nil }
        
        return action.createSwipeConfiguration()
    }
}
