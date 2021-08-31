//
//  UserProfile.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

struct UserProfile: Codable {
    let id             : String
    let country        : String
    let displayName    : String
    let email          : String
    let explicitContent: [String: Bool]
    let externalUrls   : [String: String]
    let product        : String
    let images         : [UserImage]
    
    enum CodingKeys: String, CodingKey {
        case id
        case country
        case displayName     = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls    = "external_urls"
        case product
        case images
    }
}

struct UserImage: Codable {
    let url: String
}
