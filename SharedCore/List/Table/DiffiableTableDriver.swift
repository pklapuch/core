//
//  DiffiableTableDriver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit
import Combine

public class DiffiableTableDriver: NSObject {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, NSObject>
    
    class DataSource: UITableViewDiffableDataSource<Int, NSObject> {
    
        weak var delegate: TableViewCellActionDelegate?
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            
            return delegate?.canEdit(atIndexPath: indexPath) ?? false
        }
    }
    
    private weak var tableView: UITableView?
    private weak var dataSource: TableDataSource?
    private weak var viewSource: TableViewSource?
    private weak var observer: TableObserver?
    private weak var delegate: UITableViewDelegate?
    
    private var diffSource: DataSource?
    private(set) var defaultDelegate = DefaultTableViewDelegate()
    private var contentOffset: CGPoint?
    private var models = [NSObject]()
    
    private var bag = CombineBag()
    
    public init(tableView: UITableView,
                dataSource: TableDataSource,
                viewSource: TableViewSource,
                delegate: UITableViewDelegate? = nil,
                observer: TableObserver? = nil) {
        
        self.tableView = tableView
        self.dataSource = dataSource
        self.viewSource = viewSource
        self.delegate = delegate
        self.observer = observer
        
        super.init()
        
        defaultDelegate.onDidSelectRow
            .sink { [weak self] cellIndex in self?.observer?.tableDidTap(at: cellIndex) }
            .store(in: &bag)
        
        defaultDelegate.delegate = self
        
        viewSource.configureContainer(tableView)
        viewSource.registerCells(tableView)
        dataSource.tablePresenter = self
        
        configureDiffiableDataSource(with: tableView)
        
        diffSource?.delegate = self
        tableView.delegate = delegate ?? defaultDelegate
        
        observer?.tableDidLoad()
    }
    
    private func configureDiffiableDataSource(with tableView: UITableView) {
        
        diffSource = DataSource(tableView: tableView) { [weak self] (tableView, indexPath, model) -> UITableViewCell? in
            guard let viewSource = self?.viewSource else { return nil }
            let cell = viewSource.createCell(model, indexPath: indexPath, container: tableView)
            
            return cell
        }
    }
}

extension DiffiableTableDriver: TableViewCellActionDelegate {
    
    public func canEdit(atIndexPath indexPath: IndexPath) -> Bool {
        
        let row = indexPath.row
        guard row >= 0 && row < models.count else { return false }
        guard let model = models[row] as? ActionCell else { return false }
        
        return model.leadingSwipeAction != nil || model.trailingSwipeAction != nil
    }
    
    public func getLeadingAction(atIndexPath indexPath: IndexPath) -> CellSwipeActionModel? {
        
        let row = indexPath.row
        guard row >= 0 && row < models.count else { return nil }
        guard let model = models[row] as? ActionCell else { return nil }
        
        return model.leadingSwipeAction
    }
    
    public func getTrailingAction(atIndexPath indexPath: IndexPath) -> CellSwipeActionModel? {
        
        let row = indexPath.row
        guard row >= 0 && row < models.count else { return nil }
        guard let model = models[row] as? ActionCell else { return nil }
        
        return model.trailingSwipeAction
    }
}

extension DiffiableTableDriver: TablePresenting {
    
    public func render(sections: [CollectionSection], animated: Bool) {
        
        let sectionIdentifiers = sections.map { $0.identifier }
        
        var snapshot = Snapshot()
        snapshot.appendSections(sectionIdentifiers)
        sections.forEach { snapshot.appendItems($0.models, toSection: $0.identifier) }
        
        diffSource?.apply(snapshot, animatingDifferences: animated)
        models = sections.first?.models ?? []
    }
    
    public func batchUpdate(sections: [CollectionSection], animated: Bool) {
        
        // Only applicable to manual data source
    }
    
    public func isVisible(cellIndex: CellIndex) -> Bool {
         
        if let rows = tableView?.indexPathsForVisibleRows {
            if rows.first(where: { $0.section == cellIndex.section && $0.row == cellIndex.row }) != nil {
                return true
            }
        }
        
        return false
    }
    
    public func scroll(to cellIndex: CellIndex, animated: Bool) {
        
        let indexPath = IndexPath(row: cellIndex.row, section: cellIndex.section)
        tableView?.scrollToRow(at: indexPath, at: .top, animated: animated)
    }
    
    public func beginUpdates() {
        
        contentOffset = tableView?.contentOffset
        tableView?.beginUpdates()
    }
    
    public func endUpdates() {
        
        tableView?.endUpdates()
        tableView?.layer.removeAllAnimations()
        
        if let offsetBeforeAnimation = self.contentOffset {
            
            guard let currentOffset = tableView?.contentOffset else { return }
            
            if currentOffset.y < offsetBeforeAnimation.y {
                tableView?.setContentOffset(CGPoint.zero, animated: false)
            } else {
                tableView?.setContentOffset(offsetBeforeAnimation, animated: false)
            }
            
            self.contentOffset = nil
        }
    }
    
    public func reloadSection(index: Int) {
        
        // Not applicable
    }
}
