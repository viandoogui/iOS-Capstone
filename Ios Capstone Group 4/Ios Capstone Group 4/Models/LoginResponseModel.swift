//
//  LoginResponseModel.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//
import Foundation

struct LoginResponseModel : Codable {
    var success: Bool
    var userName: String
    var accessToken: String?
    var refreshToken: String?
    var accessExpiry: Date?
    var refreshExpiry: Date?
    
    enum CodingKeys: String, CodingKey {
        case success, userName, accessToken, refreshToken
        case accessExpiry = "accessTokenExpiresAtUtc"
        case refreshExpiry = "refreshTokenExpiresAtUtc"
    }
}
