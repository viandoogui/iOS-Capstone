//
//  RemoteProductRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/12/26.
//

import Foundation

class RemoteProductRepository: RepositoryProtocol <Product> {
    
    private let urlBase: String
    
    init(urlBase: String, authStatus: AuthStatus) {
        self.urlBase = urlBase
    }
    
    func getAll() async throws -> [Product] {
        let urlString = "\(urlBase)/Product"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let formatter = DateFormatter()
            ApplyDateSettings(formatter)
            
            let decoder = ConfigureNewDecoder(formatter)
            return try decoder.decode([Product].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
    func getById(_ id: Int) async throws -> Product? {
        let urlString = "\(urlBase)/Product/\(id)"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let formatter = DateFormatter()
            ApplyDateSettings(formatter)
            
            let decoder = ConfigureNewDecoder(formatter)
            return try decoder.decode(Product.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
}
