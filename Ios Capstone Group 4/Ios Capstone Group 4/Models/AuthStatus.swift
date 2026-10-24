//
//  AuthStatus.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 9/23/26.
//

import SwiftUI
internal import Combine

class AuthStatus: ObservableObject {
    private let authKey = "userAccessToken"
    private let refreshKey = "userRefreshToken"
    private let refreshLengthSeconds = 604800 // 7 days * 24 hours * 60 minutes * 60 seconds
    
    private let storage: TokenStorageProtocol
    
    init(storage: TokenStorageProtocol = SecureTokenManager.shared) {
        self.storage = storage
        
        let auth = storage.getToken(key: authKey)
        let refresh = storage.getToken(key: refreshKey)
        
        self.isLoggedIn = auth != nil && refresh != nil
    }
    
    @Published private(set) var isLoggedIn = false
    var authToken: String? {
        return storage.getToken(key: authKey)
    }
    var refreshToken: String? {
        return storage.getToken(key: refreshKey)
    }
    
    func updateLoginStatus(response: LoginResponseModel) {
        withAnimation {
            isLoggedIn = response.success
        }
        
        if let auth = response.accessToken, !auth.isEmpty {
            let _ = storage.saveToken(auth, key: authKey)
        } else {
            storage.deleteToken(key: authKey)
        }
        
        // if there is a refresh token, save the token. if not, delete the token.
        if let refresh = response.refreshToken, !refresh.isEmpty {
            let _ = storage.saveToken(refresh, key: refreshKey)
        } else {
            storage.deleteToken(key: refreshKey)
        }
        
        // if the refresh token is expired, delete the token and sign out. if not, do nothing.
        // if there is no refresh expiry, immediately expire it
        let isRefreshTokenExpired = Date() > response.refreshExpiry ?? Date.distantPast
        
        if isRefreshTokenExpired {
            logOut()
        }
    }
    
    func logOut() {
        
        storage.deleteToken(key: authKey)
        storage.deleteToken(key: refreshKey)
        
        isLoggedIn = false
    }
}
