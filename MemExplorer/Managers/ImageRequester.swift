//
//  ImageRequester.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 21.06.2022.
//

import Foundation
import UIKit

public class ImageRequester {
    
    func image(for url: URL, handler: @escaping (UIImage?) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var image: UIImage?
            
            if let data = data {
                image = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                handler(image)
            }
        }
        
        task.resume()
        return task
    }
}
