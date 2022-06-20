//
//  MemesListView.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import Foundation
import UIKit

class MemesListView: UIView {
    
    @IBOutlet weak var tableView: UITableView?
    
    public func prepare() {
        self.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.3, alpha: 1.0)
    }
}
