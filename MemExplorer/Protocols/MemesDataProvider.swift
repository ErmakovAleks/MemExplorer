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
    
    @discardableResult
    /// In case of using a cached image, the function returns nil
    /// - Returns: URLSessionTask for downloading image
    func image(for url: URL, resumed: Bool, handler: @escaping ImageCompletion) -> URLSessionTask?
}
