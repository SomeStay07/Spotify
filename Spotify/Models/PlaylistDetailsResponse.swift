//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

struct PlaylistDetailsResponse: Codable {
    let id          : String
    let name        : String
    let description : String
    let externalUrls: [String: String]
    let images      : [APIImage]
    let tracks      : PlaylistTracksResponse
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id
        case description
        case name
        case images
        case tracks
    }
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
