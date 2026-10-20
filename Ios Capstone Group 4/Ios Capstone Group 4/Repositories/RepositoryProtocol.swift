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

    
}
