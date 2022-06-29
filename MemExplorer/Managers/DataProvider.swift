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
    
    func image(for url: URL, handler: @escaping (UIImage?) -> Void) -> URLSessionTask {
        if let image = self.cache.checkCache(url: url) {
            print("Cached!")
            handler(image)
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                var image: UIImage?
                
                data.map { image = UIImage(data: $0) }
                
                DispatchQueue.main.async {
                    handler(image)
                }
            }
            return task
        } else {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    print("Downloaded!")
                    self.cache.addToCacheFolder(image: image, url: url)
                    handler(image)
                } else { handler(nil) }
            }
            return self.innerProvider.image(for: url, handler: handler)
        }
    }
    
    /**
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            return pokemons
    }
    
    func details(url: URL) -> Single<PokemonDetails> {
        let details = self.innerProvider.details(url: url)
        return details
    }
    
    func pokemonImage(url: URL, handler: @escaping ((UIImage?) -> Void)) {
        if let image = self.cache.checkCache(url: url) {
            print("Cached!")
            handler(image)
        } else {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    print("Downloaded!")
                    self.cache.addToCacheFolder(image: image, url: url)
                    handler(image)
                } else { handler(nil) }
            }
        }
    }
     */
}
