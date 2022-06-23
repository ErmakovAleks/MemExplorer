//
//  TableViewExtension.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 22.06.2022.
//

import UIKit

extension UITableView {
    
    func registerCell(cellClass: AnyClass) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<Result>(withCellClass cellClass: Result.Type, for indexPath: IndexPath) -> Result
        where Result: UITableViewCell
    {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath)
        
        guard let value = cell as? Result else {
            fatalError("Dont find identifire")
        }
        
        return value
    }
}
