//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 20.06.2021.
//

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id   : String
    let name : String
    let icons: [APIImage]
}
