//
//  MemeDescriptionCellTableViewCell.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import UIKit

class MemeDescriptionCell: UITableViewCell {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var memeImage: UIImageView?
    @IBOutlet var memeDescriptionLabel: UILabel?
    
    // MARK: -
    // MARK: Variables
    
    private var spinner = UIActivityIndicatorView(style: .medium)
    public var url: URL?
    public var onReuse: F.VoidCompletion?
    
    // MARK: -
    // MARK: Functions
    
    func setCell(image: UIImage) {
        self.memeImage?.image = image
    }
    
    func addSpinner() {
        self.memeImage?.addSubview(self.spinner)
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        if let memeImage = memeImage {
            self.spinner.centerXAnchor.constraint(equalTo: memeImage.centerXAnchor).isActive = true
            self.spinner.centerYAnchor.constraint(equalTo: memeImage.centerYAnchor).isActive = true
        }
        self.spinner.startAnimating()
    }
    
    func removeSpinner() {
        self.spinner.removeFromSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.onReuse?()
        self.memeImage?.image = nil
    }
}
