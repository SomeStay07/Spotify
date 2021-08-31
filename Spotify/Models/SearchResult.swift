//
//  SearchResult.swift
//  Spotify
//
//  Created by Тимур Чеберда on 04.07.2021.
//

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
