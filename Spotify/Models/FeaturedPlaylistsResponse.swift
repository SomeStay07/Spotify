//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 25.04.2021.
//

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let id          : String
    let displayName : String
    let externalUrls: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case displayName  = "display_name"
        case externalUrls = "external_urls"
        case id
    }
}
