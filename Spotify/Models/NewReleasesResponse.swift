//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 22.04.2021.
//

struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let id              : String
    let name            : String
    let albumType       : String
    let availableMarkets: [String]
    let images          : [APIImage]
    let releaseDate     : String
    let totalTracks     : Int
    let artists         : [Artist]
    
    enum CodingKeys: String, CodingKey {
        case albumType        = "album_type"
        case availableMarkets = "available_markets"
        case releaseDate      = "release_date"
        case totalTracks      = "total_tracks"
        case images
        case id
        case name
        case artists
    }
}

