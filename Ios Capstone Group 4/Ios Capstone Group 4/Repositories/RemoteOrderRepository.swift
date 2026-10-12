//
//  RemoteOrderRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/12/26.
//

import Foundation

class RemoteOrderRepository: RepositoryProtocol <Order> {
    
    private let urlBase: String
    
    init(urlBase: String, authStatus: AuthStatus) {
        self.urlBase = urlBase
    }
    
    func getAll() async throws -> [Order] {
        let urlString = "\(urlBase)/Order/store"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Order].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
    func getById(_ id: Int) async throws -> Order? {
        let urlString = "\(urlBase)/Order/store/\(id)"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Order.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
}
