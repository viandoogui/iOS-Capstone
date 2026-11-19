//
//  RepositoryProtocol.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

protocol RepositoryProtocol<Item> {
    
    associatedtype Item: Identifiable, Codable
 
    func getAll() async throws -> [Item]
    func getById(_ id: Item.ID) async throws -> Item?

    func update(newCount: Int, productId:Int, locationId:Int) async throws
   
}

extension RepositoryProtocol {
    func update(newCount: Int, productId: Int, locationId: Int) async throws {
        fatalError("Update count not supported for this repository.")
    }
}
