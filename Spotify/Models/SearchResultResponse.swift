//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 04.07.2021.
//

struct SearchResultResponse: Codable {
    let albums   : SearchAlbumResponse
    let artists  : SearchArtistsResponse
    let playlists: SearchPlaylistResponse
    let tracks   : SearchTracksResponse
}

struct SearchAlbumResponse: Codable {
    let items: [Album]
}

struct SearchArtistsResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistResponse: Codable {
    let items: [Playlist]
}

struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
