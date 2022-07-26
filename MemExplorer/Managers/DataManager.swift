//
//  DataProvider.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import Foundation
import UIKit

class DataManager: MemesDataProvidable, ImageTaskHandlerGettable {
    
    // MARK: -
    // MARK: Variables
    
    var link: String = MemesAPI.environment()
    var innerProvider: MemesDataProvidable & ImageTaskGettable
    var cache: MemesCacheble
    
    init(innerProvider: MemesDataProvidable & ImageTaskGettable, cache: MemesCacheble) {
        self.innerProvider = innerProvider
        self.cache = cache
    }
    
    // MARK: -
    // MARK: MemesDataProvider Functions
    
    func memesList(handler: @escaping MemesCardsCompletion) {
        self.innerProvider.memesList(handler: handler)
    }
    
    func image(
        for url: URL,
        resumed: Bool = true,
        handler: @escaping ImageCompletion,
        taskHandler: @escaping TaskCompletion
    ) {
        self.cache.checkCache(url: url) { [weak self] result in
            switch result {
            case .success(let image):
                taskHandler(nil)
                handler(.success(image))
            case .failure(_):
                let completion = { (result: Result<UIImage, Error>) in
                    switch result {
                    case .success(let image):
                        self?.cache.addToCacheFolder(image: image, url: url) {
                            handler(.success(image))
                        }
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
                let task = self?.innerProvider.imageTask(for: url, handler: completion)
                if resumed {
                    task?.resume()
                }
                taskHandler(task)
            }
        }
    }
}
