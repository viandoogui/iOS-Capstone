//
//  MockInventoryRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

import Foundation

class MockInventoryRepository: RepositoryProtocol<Inventory>{

    func getAll() async throws -> [Inventory] {
        items
    }
    
    func getById(_ id: Int) async throws -> Inventory? {
        items.first(where: { $0.productId == $0.productId})
    }
    
    func insert(_ item: Inventory) async throws -> Inventory {
        items.append(item)
        return item
    }
    
    func update(_ item: Inventory) async throws {
        items.removeAll(where: { $0.productId == item.productId})
        items.append(item)
    }
    
    func delete(_ item: Inventory) async throws {
        items.removeAll(where: { $0.productId == item.productId})
    }
    
    var items: [Inventory] = [
        Inventory(
                productId: 1,
                productName: "Adjustable Race",
                productNumber: "AR-5381",
                safetyStockLevel: 1000,
                reorderPoint: 750,
                locationId: 1,
                locationName: "Tool Crib",
                shelf: "A",
                bin: 1,
                quantity: 195
            ),
            
            Inventory(
                productId: 1,
                productName: "Adjustable Race",
                productNumber: "AR-5381",
                safetyStockLevel: 1000,
                reorderPoint: 750,
                locationId: 6,
                locationName: "Miscellaneous Storage",
                shelf: "B",
                bin: 5,
                quantity: 325
            ),
            
            Inventory(
                productId: 2,
                productName: "Bearing Ball",
                productNumber: "BA-8327",
                safetyStockLevel: 1000,
                reorderPoint: 750,
                locationId: 1,
                locationName: "Tool Crib",
                shelf: "A",
                bin: 2,
                quantity: 427
            ),
            
            Inventory(
                productId: 2,
                productName: "Bearing Ball",
                productNumber: "BA-8327",
                safetyStockLevel: 1000,
                reorderPoint: 750,
                locationId: 50,
                locationName: "Subassembly",
                shelf: "A",
                bin: 6,
                quantity: 364
            ),
            
            Inventory(
                productId: 3,
                productName: "BB Ball Bearing",
                productNumber: "BE-2349",
                safetyStockLevel: 800,
                reorderPoint: 600,
                locationId: 1,
                locationName: "Tool Crib",
                shelf: "A",
                bin: 7,
                quantity: 586
            ),
            
            Inventory(
                productId: 3,
                productName: "BB Ball Bearing",
                productNumber: "BE-2349",
                safetyStockLevel: 800,
                reorderPoint: 600,
                locationId: 50,
                locationName: "Subassembly",
                shelf: "A",
                bin: 10,
                quantity: 324
            ),
            
            Inventory(
                productId: 4,
                productName: "Headset Ball Bearings",
                productNumber: "BE-2908",
                safetyStockLevel: 800,
                reorderPoint: 600,
                locationId: 6,
                locationName: "Miscellaneous Storage",
                shelf: "B",
                bin: 10,
                quantity: 422
            ),
            
            Inventory(
                productId: 316,
                productName: "Blade",
                productNumber: "BL-2036",
                safetyStockLevel: 800,
                reorderPoint: 600,
                locationId: 5,
                locationName: "Metal Storage",
                shelf: "A",
                bin: 11,
                quantity: 532
            ),
            
            Inventory(
                productId: 317,
                productName: "LL Crankarm",
                productNumber: "CA-5965",
                safetyStockLevel: 500,
                reorderPoint: 375,
                locationId: 1,
                locationName: "Tool Crib",
                shelf: "C",
                bin: 1,
                quantity: 281
            ),
            
            Inventory(
                productId: 318,
                productName: "ML Crankarm",
                productNumber: "CA-6738",
                safetyStockLevel: 500,
                reorderPoint: 375,
                locationId: 5,
                locationName: "Metal Storage",
                shelf: "A",
                bin: 2,
                quantity: 171
            ),
            
            Inventory(
                productId: 325,
                productName: "Decal 1",
                productNumber: "DC-8732",
                safetyStockLevel: 1000,
                reorderPoint: 750,
                locationId: 60,
                locationName: "Final Assembly",
                shelf: "A",
                bin: 1,
                quantity: 641
            ),
            
            Inventory(
                productId: 327,
                productName: "Down Tube",
                productNumber: "DT-2377",
                safetyStockLevel: 800,
                reorderPoint: 600,
                locationId: 50,
                locationName: "Subassembly",
                shelf: "B",
                bin: 9,
                quantity: 513
            )
    ]
}
