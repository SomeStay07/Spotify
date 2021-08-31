//
//  Playlist.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

struct Playlist: Codable {
    let id          : String
    let name        : String
    let description : String
    let externalUrls: [String: String]
    let images      : [APIImage]
    let owner       : User
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id
        case name
        case description
        case images
        case owner
    }
}
