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
    
    private var imageRequester = ImageRequester()
    private var imageRequest: URLSessionTask?
    
    // MARK: -
    // MARK: Functions
    
    func setImage(url: URL) {
        self.imageRequest = self.imageRequester.image(for: url) { [weak self] image in
            self?.memeImage?.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.memeImage?.image = nil
        self.imageRequest?.cancel()
    }
}
