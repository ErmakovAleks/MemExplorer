//
//  MemesListView.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import Foundation
import UIKit

class MemesListView: UIView {
    
    var controller: MemesListViewController?
    
    public func prepare(with controller: MemesListViewController) {
        self.controller = controller
        self.backgroundColor = .blue
    }
}
