//
//  RemoteBestWorstRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

class RemoteBestWorstRepository: RepositoryProtocol <BestWorstProduct> {
    
    private let urlBase: String
    
    init(urlBase: String, authStatus: AuthStatus) {
        self.urlBase = urlBase
    }
    
    func getAll() async throws -> [BestWorstProduct] {
        let urlString = "\(urlBase)/Dashboard/best-worst"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            // this was necessary because the date format would cause a decodingError
            // the compiler was expecting a double and got the date as a string.
            let formatter = DateFormatter()
            ApplyDateSettings(formatter)
            let decoder = ConfigureNewDecoder(formatter)
            
            return try decoder.decode([BestWorstProduct].self, from: data)
        } catch {
            print(error)
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
    func getById(_ id: Int) async throws -> BestWorstProduct? {
        let bestAndWorst = try await getAll()
        
        return bestAndWorst.first(where: {$0.id == id})
    }
    
}
