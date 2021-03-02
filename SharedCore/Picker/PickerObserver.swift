//
//  PickerObserver.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import Foundation

public protocol PickerObserver: class {
    
    func didSelect(row: Int, inComponent component: Int)
}
