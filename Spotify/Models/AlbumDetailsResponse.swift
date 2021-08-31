//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

struct AlbumDetailsResponse: Codable {
    let id              : String
    let label           : String
    let name            : String
    let albumType       : String
    let artists         : [Artist]
    let availableMarkets: [String]
    let externalUrls    : [String: String]
    let images          : [APIImage]
    let tracks          : TracksResponse
    
    enum CodingKeys: String, CodingKey {
        case albumType        = "album_type"
        case externalUrls     = "external_urls"
        case availableMarkets = "available_markets"
        case id
        case label
        case name
        case artists
        case images
        case tracks
    }
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}
