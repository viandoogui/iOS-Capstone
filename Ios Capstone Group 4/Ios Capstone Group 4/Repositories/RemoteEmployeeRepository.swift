//
//  RemoteEmployeeRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/9/26.
//

import Foundation

class RemoteEmployeeRepository: RepositoryProtocol <Employee> {
    
    private let urlBase: String
    
    init(urlBase: String, authStatus: AuthStatus) {
        self.urlBase = urlBase
    }
    
    
    
    func getAll() async throws -> [Employee] {
        let urlString = "\(urlBase)/Employee"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            // this was necessary because the date format would cause a decodingError
            // the compiler was expecting a double and got the date as a string.
            let formatter = DateFormatter()
            ApplyDateSettings(formatter)
            let decoder = ConfigureNewDecoder(formatter)
            
            return try decoder.decode([Employee].self, from: data)
        } catch {
            print(error)
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
    func getById(_ id: Int) async throws -> Employee? {
        let urlString = "\(urlBase)/Employee/\(id)"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Employee.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
}
