//
//  Cancellable.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 21.06.2022.
//

import Foundation

protocol Cancellable {
    
    func cancel()
}

extension URLSessionTask: Cancellable {}
