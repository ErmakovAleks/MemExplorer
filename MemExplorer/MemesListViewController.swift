//
//  MemesListViewController.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import UIKit

class MemesListViewController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = MemesListView
    
    // MARK: -
    // MARK: Variables
    
    var rootView: MemesListView?
    
    // MARK: -
    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        self.rootView?.prepare(with: self)
        super.viewDidLoad()
    }
}
