//
//  NativePickerDriver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public class NativePickerDriver: NSObject {
    
    private weak var pickerView: UIPickerView?
    private weak var dataSource: PickerDataSource?
    private weak var observer: PickerObserver?
    
    public init(pickerView: UIPickerView?, dataSource: PickerDataSource, observer: PickerObserver) {
        
        self.pickerView = pickerView
        self.dataSource = dataSource
        self.observer = observer
        super.init()
        
        setupPicker()
    }
    
    private func setupPicker() {
        
        pickerView?.dataSource = self
        pickerView?.delegate = self
        dataSource?.pickerDelegate = self
    }
}

extension NativePickerDriver: PickerDriving {
    
    public func reloadAllComponents() {
        
        pickerView?.reloadAllComponents()
    }
    
    public func selectItem(at row: Int, component: Int, animated: Bool) {
        
        pickerView?.selectRow(row, inComponent: component, animated: animated)
    }
}

extension NativePickerDriver: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        guard let dataSource = dataSource else { return 0 }
        let components = dataSource.getNumberOfComponents()
        
        return components
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let dataSource = dataSource else { return 0 }
        return dataSource.getNumberOfRows(inComponent: component)
    }
}

extension NativePickerDriver: UIPickerViewDelegate{
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataSource?.getTitle(forRow: row, forComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        observer?.didSelect(row: row, inComponent: component)
    }
}
