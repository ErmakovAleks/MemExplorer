//
//  DataProvider.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import Foundation
import UIKit

class DataProvider: MemesDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    var link: String = MemesAPI.environment()
    var innerProvider: MemesDataProvider
    var cache: MemesCacheble
    
    init(innerProvider: MemesDataProvider, cache: MemesCacheble) {
        self.innerProvider = innerProvider
        self.cache = cache
    }
    
    // MARK: -
    // MARK: MemesDataProvider Functions
    
    func memesList(handler: @escaping MemesCardsCompletion) {
        self.innerProvider.memesList(handler: handler)
    }
    
    func image(for url: URL, resumed: Bool = true, handler: @escaping ImageCompletion) -> URLSessionTask? {
        var task: URLSessionTask?
        self.cache.checkCache(url: url) { result in
            switch result {
            case .success(let image):
                handler(.success(image))
            case .failure(_):
                let completion = { (result: Result<UIImage, Error>) in
                    switch result {
                    case .success(let image):
                        self.cache.addToCacheFolder(image: image, url: url) {
                            handler(.success(image))
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                task = self.innerProvider.image(for: url, resumed: resumed, handler: completion)
            }
        }
        return task
    }
}
