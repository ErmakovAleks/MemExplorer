//
//  Associated Types.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation
import UIKit

typealias Completion<T> = (Result<T, Error>) -> ()
typealias ImageCompletion = Completion<UIImage>
typealias MemesCardsCompletion = Completion<[Meme]>
