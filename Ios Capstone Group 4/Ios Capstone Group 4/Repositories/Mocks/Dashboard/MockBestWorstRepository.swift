//
//  MockBestWorstRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//
import Foundation

class MockBestWorstRepository: RepositoryProtocol<BestWorstProduct>{
    
    func getAll() async throws -> [BestWorstProduct] {
        bestAndWorstProducts
    }
    
    func getById(_ id: Int) async throws -> BestWorstProduct? {
        bestAndWorstProducts.first(where: { $0.id == id})
    }
    
    private var bestAndWorstProducts: [BestWorstProduct] = [
        BestWorstProduct(productId: 1, productName: "Best Performing Product", unitsSold: 53, unitsInStock: 401),
        BestWorstProduct(productId: 2, productName: "Worst Performing Product", unitsSold: 1, unitsInStock: 313)
        ]
}

