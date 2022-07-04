//
//  MemesCacheble.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import Foundation
import UIKit

protocol MemesCacheble {
    
    func addToCacheFolder(image: UIImage, url: URL, handler: @escaping () -> Void)
    
    func checkCache(url: URL, handler: @escaping ImageCompletion)
}
