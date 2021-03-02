//
//  PickerDriving.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol PickerDriving: class {
    
    func reloadAllComponents()
    
    func selectItem(at row: Int, component: Int, animated: Bool)
}
