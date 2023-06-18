//
//  Network.swift
//  iOS_APP_1
//
//  Created by 계은성 on 2023/06/07.
//

import Foundation


// MARK: - Welcome
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
struct Music: Codable {
    
    
    // 옵셔널 필수
    let imageUrl: String?
    
    let songName: String?
    let artistName: String?
    let albumName: String?
    let previewURL: String?
    
    
    // 연습
    let genres: [String]?
//    private let releaseDate: Date
    

    enum CodingKeys: String, CodingKey {
        
        case imageUrl = "artworkUrl100"
        
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewURL
        
        
        // 연습
        case genres
//        case releaseDate
    }
}
