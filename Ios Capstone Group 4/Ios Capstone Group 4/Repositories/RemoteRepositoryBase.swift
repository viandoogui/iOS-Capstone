//
//  RemoteRepositoryBase.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/30/26.
//


import Foundation
import CoreData
class RemoteRepositoryBase<Item: Codable>{
    
    
    private var authStatus:AuthStatus
    
    var implicitContext: NSManagedObjectContext? = nil
    
    
    init(authStatus:AuthStatus){
        self.authStatus = authStatus
    }
    
    
    func post(_ urlString: String, send item: Item) async throws -> Item{
        var request = try createRequest(urlString)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(item)
        }catch{
            throw NetworkError.encodingFailed(underlying: error)
        }
        
        let data = try await executeRequest(request)
        
        do{
            let decoder = JSONDecoder()
            if let context = implicitContext{
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Item.self, from:data)
    
            
        }catch{
            throw NetworkError.decodingFailed(underlying:error)
        }
        
        
    }
    
    
    func put<T:Encodable>(_ urlString:String, send payoad: T) async throws{
        var request = try createRequest(urlString)

        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        do {
            request.httpBody = try JSONEncoder().encode(payoad)
        }catch{
            throw NetworkError.encodingFailed(underlying: error)
        }
        
        let _ = try await executeRequest(request)
        
        
    }
    
   
    
    
    
    
    
    //MARK: - private utility methods
    private func createRequest(_ urlString:String) throws -> URLRequest{
        guard let url = URL(string: urlString) else{
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        // add authorization to this later
        
        guard let auth = authStatus.authToken, !auth.isEmpty else{
            throw NetworkError.missingAuthToken
        }
        request.setValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")

        return request
    }
    
    private func executeRequest(_ request: URLRequest, isRetry:Bool = false) async throws -> Data{
        
        let (data , response) = try await URLSession.shared.data(for:request) //cast
        
        guard let http = response as? HTTPURLResponse else{
            throw NetworkError.badResponse(statusCode: -1)
        }
        
        guard (200...299).contains(http.statusCode) else{ //check for valid status
            if http.statusCode == 401{
                
                guard !isRetry,
                        let refresh = authStatus.refreshToken,
                        !refresh.isEmpty,
                        let auth = authStatus.authToken,
                        !auth.isEmpty
                else{
                    throw NetworkError.unauthorized
                }

                //create a copy of the original request, as it is a let constant
                var newRequest = request
                newRequest.setValue(" Bearer \(authStatus.authToken!)", forHTTPHeaderField: "Authorization")
                return try await executeRequest(newRequest, isRetry: true)
            }
            throw NetworkError.badResponse(statusCode: http.statusCode)
        }
        
        return data
    }
    
}
