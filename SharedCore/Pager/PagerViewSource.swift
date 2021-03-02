//
//  PagerViewSource.swift
//  SharedCore
//
//  Created by Pawel Klapuch on 2/9/21.
//

import UIKit

public protocol PagerViewSource: class {
    
    func createViewController(for model: AnyObject) throws -> UIViewController
}
