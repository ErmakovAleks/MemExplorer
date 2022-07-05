//
//  Associated Types.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation
import UIKit

// MARK: -
// MARK: Type Inferences

typealias ImageCompletion = ResultCompletion<UIImage>

typealias ResultCompletion<T> = (Result<T, Error>) -> ()


