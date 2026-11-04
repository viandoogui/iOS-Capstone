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
    
    //this is for updating inventory counts. no one else should use this.
    //If you get error because of this please talk to Thomas.
    func update(newCount: Int, productId:Int, locationId:Int) async throws
   
}


//this is just so repository protocol other than Inventory dont need to implement it
//will throw error if implemented.
//ideally update would be siloed to its own class but,
//due to time constraints and how I originally built it, this works best for now
//any issues talk to Thomas
extension RepositoryProtocol {
    func update(newCount: Int, productId: Int, locationId: Int) async throws {
        fatalError("Update count not supported for this repository.")
    }
}
