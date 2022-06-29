//
//  MemesCacheble.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import Foundation
import UIKit

protocol MemesCacheble {
    
    func addToCacheFolder(image: UIImage, url: URL)
    
    func checkCache(url: URL) -> UIImage?
}
