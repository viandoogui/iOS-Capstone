//
//  FakeTokenManager.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/24/26.
//

import Testing
import Foundation
@testable import Ios_Capstone_Group_4

struct FakeTokenManager : TokenStorageProtocol {
    
    func getToken(key: String) -> String? {
        return key
    }
    
    func saveToken(_ token: String, key: String) -> Bool {
        return true
    }
    
    func deleteToken(key: String) {
        
    }
    
    
}
