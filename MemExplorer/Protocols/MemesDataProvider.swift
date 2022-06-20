//
//  MemesProvider.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation
import UIKit

// MARK: -
// MARK: Enums

enum MemesAPI: String {
    
    case dev = "https://api.imgflip.com/get_memes"
    case prod = "https://another-link"
    
    
    static func environment() -> String {
        #if DEBUG
        return MemesAPI.dev.rawValue
        #else
        return MemesAPI.prod.rawValue
        #endif
    }
}

enum Errors: Error {
    case notValidUrl
}

// MARK: -
// MARK: Provider Requirements Protocol

protocol MemesDataProvider {
    
    var link: String { get }
    
    func memesList(handler: @escaping MemesCardsCompletion)
    
    func memeImage(url: URL, handler: @escaping ((UIImage?) -> Void))
}

extension MemesDataProvider {
    
    func memeImage(url: URL, handler: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            var image: UIImage?
            if let data = try? Data(contentsOf: url) {
                image = UIImage(data: data)
            }
            handler(image)
        }
    }
}
