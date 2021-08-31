//
//  AudioTrack.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

struct AudioTrack: Codable {
    let id              : String
    let name            : String
    let album           : Album?
    let artists         : [Artist]
    let availableMarkets: [String]
    let discNumber      : Int
    let durationMs      : Int
    let explicit        : Bool
    let externalUrls    : [String: String]
    
    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case discNumber       = "disc_number"
        case durationMs       = "duration_ms"
        case externalUrls     = "external_urls"
        case id
        case name
        case album
        case explicit
        case artists
    }
}
