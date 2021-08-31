//
//  SettingsModel.swift
//  Spotify
//
//  Created by Тимур Чеберда on 21.04.2021.
//

struct Section {
    let title  : String
    let options: [Option]
}

struct Option {
    let title  : String
    let handler: () -> Void
}
