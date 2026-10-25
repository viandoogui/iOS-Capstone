//
//  AuthStatusTests.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/24/26.
//

import Testing
import Foundation
@testable import Ios_Capstone_Group_4

struct AuthStatusTests {

    @Test func sign_Out_User_On_Expired_Refresh_Token() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        // Swift Testing Documentation
        // https://developer.apple.com/documentation/testing
        
        let response = LoginResponseModel(
            success: true,
            userName: "fakeUserName",
            accessToken: "abc",
            refreshToken: "xyz",
            accessExpiry: Date.distantPast,
            refreshExpiry: Date.distantPast
        )
        
        let authStatus = await AuthStatus(storage: FakeTokenManager())
        
        await authStatus.updateLoginStatus(response: response)
        
        #expect (authStatus.isLoggedIn == false)
    }
    
    @Test func sign_In_User_With_Valid_Credentials() async throws {
        let response = LoginResponseModel(
            success: true,
            userName: "fakeUserName",
            accessToken: "abc",
            refreshToken: "xyz",
            accessExpiry: Date.distantFuture,
            refreshExpiry: Date.distantFuture
        )
        
        let authStatus = await AuthStatus(storage: FakeTokenManager())
        
        await authStatus.updateLoginStatus(response: response)
        
        #expect (authStatus.isLoggedIn == true)
    }
    
    @Test func accept_User_With_Refresh_Under_7_Days() async throws {
        let response = LoginResponseModel(
            success: true,
            userName: "fakeUserName",
            accessToken: "abc",
            refreshToken: "xyz",
            accessExpiry: Date(),
            refreshExpiry: Date().addingTimeInterval(518400)
        )
        
        let authStatus = await AuthStatus(storage: FakeTokenManager())
        
        await authStatus.updateLoginStatus(response: response)
        
        #expect (authStatus.isLoggedIn == true)
    }
    
    @Test func signs_Out_User_On_Logout() async throws {
        let response = LoginResponseModel(
            success: true,
            userName: "fakeUserName",
            accessToken: "abc",
            refreshToken: "xyz",
            accessExpiry: Date.distantFuture,
            refreshExpiry: Date.distantFuture
        )
        
        let authStatus = await AuthStatus(storage: FakeTokenManager())
        
        await authStatus.updateLoginStatus(response: response)
        
        await authStatus.logOut()
        
        #expect (authStatus.isLoggedIn == false)
    }

}
