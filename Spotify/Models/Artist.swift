//
//  Artist.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

struct Artist: Codable {
    let id          : String
    let name        : String
    let type        : String
    let images      : [APIImage]?
    let externalUrls: [String: String]

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id
        case name
        case type
        case images
    }
}
