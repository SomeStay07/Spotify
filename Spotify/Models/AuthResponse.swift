//
//  AuthResponse.swift
//  Spotify
//
//  Created by Тимур Чеберда on 18.04.2021.
//

struct AuthResponse: Codable {
    let accessToken : String
    let expiresIn   : Int
    let refreshToken: String?
    let scope       : String
    let tokenType   : String
    
    enum CodingKeys: String, CodingKey {
        case accessToken  = "access_token"
        case expiresIn    = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType    = "token_type"
    }
}
