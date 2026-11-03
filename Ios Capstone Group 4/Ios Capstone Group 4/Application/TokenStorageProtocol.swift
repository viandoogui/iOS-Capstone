//
//  TokenStorageProtocol.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/24/26.
//

protocol TokenStorageProtocol {
    func getToken(key: String) -> String?
    func saveToken(_ token: String, key: String) -> Bool
    func deleteToken(key: String)
}
