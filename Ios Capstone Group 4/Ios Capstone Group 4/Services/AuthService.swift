//
//  AuthService.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 9/22/26.
//

import Foundation

class AuthService {
    // use the Singleton pattern
    static let shared = AuthService()
    
    private init() {}
    
    func login(credentials: LoginModel)	async throws -> LoginResponseModel {
        
        let urlString = "https://api.bootcampcentral.com/api/Login"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(credentials)
        }
        catch {
            throw NetworkError.encodingFailed(underlying: error)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.badResponse(statusCode: -1)
        }
        
        guard (200...299).contains(http.statusCode) else {
            if http.statusCode == 401 {
                throw NetworkError.unauthorized
            }
            throw NetworkError.badResponse(statusCode: http.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.useStringDecoderForDate()
            
            return try decoder.decode(LoginResponseModel.self, from: data)
        }
        catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
        
    }
    
}
