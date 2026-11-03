//
//  RemoteInventoryRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/12/26.
//
import Foundation
import CoreData
class RemoteInventoryRepository: RemoteRepositoryBase<Inventory>, RepositoryProtocol <Inventory>  {
    
    private let urlBase: String
    
    init(urlBase: String, authStatus: AuthStatus) {
        self.urlBase = urlBase
        super.init(authStatus: authStatus)

    }
    
    func getAll() async throws -> [Inventory] {
        let urlString = "\(urlBase)/Inventory"
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let formatter = DateFormatter()
            ApplyDateSettings(formatter)
            
            let decoder = ConfigureNewDecoder(formatter)
            return try decoder.decode([Inventory].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(underlying: error)
        }
    }
    
    func getById(_ id: Int) async throws -> Inventory? {
        let inventories = try await getAll()
        
        return inventories.first(where: { $0.id == id })
    }
    
    
    func update(newCount: Int, productId:Int, locationId:Int) async throws {
        let urlString = "\(urlBase)/Inventory/\(productId)/\(locationId)"
        
        struct Payload:Codable{
            let quantity:Int
            let productId:Int
            let locationId:Int
        }
        
        let payload = Payload(quantity: newCount, productId:productId, locationId: locationId)
        try await put(urlString, send: payload)
    }
    
    
}
