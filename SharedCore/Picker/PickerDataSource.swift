//
//  PickerDataSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol PickerDataSource: class {
    
    var pickerDelegate: PickerDriving? { get set }
    
    func getNumberOfComponents() -> Int
    
    func getNumberOfRows(inComponent component: Int) -> Int
    
    func getTitle(forRow row: Int, forComponent component: Int) -> String?
}
