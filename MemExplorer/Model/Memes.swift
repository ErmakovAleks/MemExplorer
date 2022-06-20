//
//  Memes.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 20.06.2022.
//

import Foundation

// MARK: - MemesResponse
struct MemesResponse: Codable {
    let success: Bool?
    let data: Memes?
}

// MARK: -
// MARK: Memes
struct Memes: Codable {
    let memes: [Meme]?
}

// MARK: - Meme
struct Meme: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
    
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let boxCount: Int
}
