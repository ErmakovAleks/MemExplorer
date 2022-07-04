//
//  CacheManager.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import Foundation
import UIKit

class CacheManager: MemesCacheble {
    
    // MARK: -
    // MARK: Variables
    
    private var fileManager = FileManager.default
    private var cachedImagesFolderURL: URL?
    
    // MARK: -
    // MARK: Initializators
    
    init() {
        checkAndCreateDirectory()
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func pathForCacheDirectory() -> URL? {
        self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private func checkAndCreateDirectory() {
        self.fileManager = FileManager.default
        self.cachedImagesFolderURL = self.fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("cachedImages")
        
        do {
            if let url = self.cachedImagesFolderURL {
                try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            }
        }
    }
    
    // MARK: -
    // MARK: Memes Cacheble Functions
    
    func addToCacheFolder(image: UIImage, url: URL, handler: @escaping () -> Void) {
        if let percentURL = url.absoluteString
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let pngImage = image.pngData(),
           let fileURL = self.cachedImagesFolderURL?
            .appendingPathComponent(percentURL)
        {
            DispatchQueue.global(qos: .background).async {
                do {
                    try pngImage.write(to: fileURL)
                    handler()
                } catch {
                    print(error.localizedDescription)
                    handler()
                }
            }
        }
    }
    
    func checkCache(url: URL, handler: @escaping ImageCompletion) {
        DispatchQueue.global(qos: .background).async {
            let image = url
                .absoluteString
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                .flatMap { self.cachedImagesFolderURL?.appendingPathComponent($0) }
                .flatMap { try? Data(contentsOf: $0) }
                .flatMap { UIImage(data: $0) }
            if let image = image {
                handler(.success(image))
            } else {
                handler(.failure(Errors.notValidUrl))
            }
        }
    }
}
