//
//  Associated Types.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation

typealias Completion<T> = (Result<T, Error>) -> ()
typealias MemesCardsCompletion = Completion<[Meme]>
