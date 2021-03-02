//
//  CollectionDriver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit
import Combine

public class CollectionDriver: NSObject {
    
    let onWillDrag = PassthroughSubject<CGFloat, Never>()
    let onDidScroll = PassthroughSubject<CGFloat, Never>()
    
    private let layout: CollectionLayout?
    private weak var collectionView: UICollectionView?
    private weak var dataSource: CollectionDataSource?
    private weak var viewSource: CollectionViewSource?
    private weak var observer: CollectionObserver?
    private var refreshControl: UIRefreshControl?
    private let diffiableDataSource: DiffiableDataSource?
    
    public init(collectionView: UICollectionView,
                dataSource: CollectionDataSource,
                viewSource: CollectionViewSource,
                observer: CollectionObserver? = nil,
                layout: CollectionLayout? = nil,
                pullToRefreshEnabled: Bool? = nil) {
        
        self.collectionView = collectionView
        self.dataSource = dataSource
        self.viewSource = viewSource
        self.observer = observer
        self.layout = layout
        
        viewSource.registerCells(collectionView)
        viewSource.configureContainer(collectionView)
        diffiableDataSource = DiffiableDataSource(collectionView: collectionView, viewSource: viewSource)
        
        super.init()
        dataSource.collectionPresenter = self
        collectionView.delegate = self
        
        if let layout = layout {
            collectionView.collectionViewLayout = layout
        }
        
        if let pullToRefreshEnabled = pullToRefreshEnabled, pullToRefreshEnabled {
            
            let refreshControl = UIRefreshControl()
            collectionView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(pullDownAction(_:)), for: .valueChanged)
            
            self.refreshControl = refreshControl
        }
        
        observer?.collectionDidLoad()
    }
    
    @objc private func pullDownAction(_ sender: Any) {
        
        observer?.didPullToRefresh()
    }
}

extension CollectionDriver: CollectionPresenting {
    
    public func render(sections: [CollectionSection], animated: Bool) {
    
        guard let models = sections.first?.models else { return }
        let snapshot = CollectionSnapshot.new(models)
        
        render(scrollingEnabled: false)
        layout?.set(models: models)
        diffiableDataSource?.apply(snapshot, animatingDifferences: animated)
        render(scrollingEnabled: true)
    }
    
    public func render(scrollingEnabled: Bool) {
    
        collectionView?.isScrollEnabled = scrollingEnabled
    }
    
    public func render(maintainContentOffsetForUpcomingContentChagnes: Bool) {
        
        layout?.set(lockContentOffset: maintainContentOffsetForUpcomingContentChagnes)
    }
    
    public func render(contentSizeChangeAtIndex index: Int, animated: Bool) {
        
        let indexPath = IndexPath(item: index, section: 0)
        layout?.set(scrollTargetIndexPath: indexPath)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.0,
            options: .allowUserInteraction,
            animations: { [weak self] in
                self?.layout?.invalidateLayout()
                self?.collectionView?.layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    public func renderScroll(toIndex index: Int, target: CellScrollTarget, animated: Bool) {
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: target.toUI(), animated: animated)
    }
    
    public func renderVisiblePullToRefresh() {
        
        refreshControl?.beginRefreshing()
    }
    
    public func renderHiddenPullToRefresh() {
        
        refreshControl?.endRefreshing()
    }
}

extension CollectionDriver: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        observer?.didTap(index: indexPath.item)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let collectionView = collectionView else { return }
        let contentHeight = collectionView.contentSize.height
        let contentOffsetY = collectionView.contentOffset.y
        
        let indexes = collectionView.indexPathsForVisibleItems.map { $0.item }.sorted { (lhs, rhs) -> Bool in
            return lhs < rhs
        }
        
        if let minRow = indexes.min(), let maxRow = indexes.max() {
        
            let minCellIndex = CellIndex(section: 0, row: minRow)
            let maxCellIndex = CellIndex(section: 0, row: maxRow)
        
            let maxOffset = max(0.0, contentHeight - collectionView.bounds.height)
            let rawRatio = contentOffsetY / maxOffset
            let ratio = max(min(1.0, rawRatio), 0.0)
            
            observer?.didUpdateVisible(minCellIndex: minCellIndex, maxCellIndex: maxCellIndex, offsetRatio: Double(ratio))
        }
                
        onDidScroll.send(scrollView.contentOffset.y)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        onWillDrag.send(scrollView.contentOffset.y)
    }
}

fileprivate class DataSource: CollectionDiffableDataSource {
    
    init(collectionView: UICollectionView, viewSource: CollectionViewSource) {
        
        super.init(collectionView: collectionView) { (collectionView,
                                                      indexPath,
                                                      model) -> UICollectionViewCell? in
            
            return viewSource.createCell(model,
                                         indexPath: indexPath,
                                         container: collectionView)
        }
    }
}
