//
//  Associated Types.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation
import UIKit

enum F {
    
    typealias VoidCompletion = () -> Void
}

// MARK: -
// MARK: Type Inferences

typealias ImageCompletion = ResultCompletion<UIImage>

typealias ResultCompletion<T> = (Result<T, Error>) -> ()



