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
        
        // remove this later, demo code
        self.isLoggedIn = auth != nil && refresh != nil
    }
    
    @Published private(set) var isLoggedIn = false
    var authToken: String? {
        return storage.getToken(key: authKey)
    }
    var refreshToken: String? {
        return storage.getToken(key: refreshKey)
    }
    
    func updateLoginStatus(response: LoginResponseModel)async {
        withAnimation {
            isLoggedIn = response.success
        }
        
        guard let auth = response.accessToken, !auth.isEmpty else {
            logOut()
            return
        }
        
        guard let refresh = response.refreshToken, !refresh.isEmpty else {
            logOut()
            return
        }
        
        guard let accessExpiry = response.accessExpiry, let refreshExpiry = response.refreshExpiry else {
            logOut()
            return
        }
        
        guard Date() < refreshExpiry else {
            logOut()
            return
        }
        
        // GOAL: If the access token is expired and the refresh token is valid, use the refresh token to call the api
        // and set a new response.
        if (Date() > accessExpiry) {
            // check to see if the refresh expiry is valid
            // if valid, get a new token.
            do {
                let refreshRequest = RefreshRequest(refreshToken: refreshKey)
                let newResponse = try await AuthService.shared.refresh(refreshKey: refreshRequest)
                await updateLoginStatus(response: newResponse)
            } catch {
                print("Token Refresh Failed: \(error.localizedDescription)")
                logOut()
                return
            }
        }
        
        let _ = storage.saveToken(auth, key: authKey)
        let _ = storage.saveToken(refresh, key: refreshKey)
    }
    
    func logOut() {
        
        storage.deleteToken(key: authKey)
        storage.deleteToken(key: refreshKey)
        
        isLoggedIn = false
    }
}
