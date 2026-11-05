//
//  MockLowStockRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//
import Foundation

class MockLowStockRepository: RepositoryProtocol<LowStockProduct>{
    
    func getAll() async throws -> [LowStockProduct] {
        lowStockProducts
    }
    
    func getById(_ id: Int) async throws -> LowStockProduct? {
        lowStockProducts.first(where: { $0.id == id})
    }
    
    private var lowStockProducts: [LowStockProduct] = [
        LowStockProduct(productId: 1, productName: "White Tricycle", stockLevel: 0, reorderPoint: 25),
        LowStockProduct(productId: 2, productName: "Blue Bicycle", stockLevel: 0, reorderPoint: 435),
        ]
}

