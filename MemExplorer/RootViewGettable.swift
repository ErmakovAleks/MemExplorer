//
//  RootViewGettable.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import Foundation
import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    
    var rootView: RootView? { get }
}

extension RootViewGettable {
    
    var rootView: UIView? {
        self.view as? RootView
    }
}
