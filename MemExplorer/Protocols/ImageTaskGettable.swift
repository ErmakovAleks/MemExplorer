//
//  ImageTaskGettable.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 05.07.2022.
//

import Foundation
import UIKit

protocol ImageTaskGettable {
    
    func imageTask(for url: URL, handler: @escaping ImageCompletion) -> URLSessionDataTask
}
