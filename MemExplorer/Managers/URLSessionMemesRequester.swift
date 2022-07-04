//
//  URLSessionMemesRequester.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation
import UIKit

public class URLSessionMemesRequester: MemesDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    var link: String = MemesAPI.environment()
    
    // MARK: -
    // MARK: MemesProvider
    
    func memesList(handler: @escaping MemesCardsCompletion) {
        guard let url = URL(string: self.link) else {
            return handler(.failure(Errors.notValidUrl))
        }
        
        self.commonRequest(url: url) { (results: Result<MemesResponse, Error>) in
            switch results {
            case .success(let memes):
                guard let memesArray = memes.data?.memes else { return }
                handler(.success(memesArray))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    @discardableResult
    func image(for url: URL, resumed: Bool = true, handler: @escaping ImageCompletion) -> URLSessionTask? {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var image: UIImage?
            
            if let data = data {
                image = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                image.map { handler(.success($0)) }
            }
        }
        
        let taskCopy: URLSessionDataTask? = resumed ? task : nil

        defer {
            taskCopy?.resume()
        }
        
        return task
    }
    
    
    // MARK: -
    // MARK: Private functions
    
    private func commonRequest<T: Codable>(url: URL, handler: @escaping (Result<T, Error>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let results = try? JSONDecoder().decode(T.self, from: data) {
                handler(.success(results))
            } else { print("Invalid response!") }
            if let error = error {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
