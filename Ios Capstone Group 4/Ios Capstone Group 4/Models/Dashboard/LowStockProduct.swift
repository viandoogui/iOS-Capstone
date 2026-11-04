//
//  LowStockProduct.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

struct LowStockProduct: Codable, Hashable, Identifiable {
    let productId: Int
    let productName: String
    let stockLevel: Int
    let reorderPoint: Int
    
    var id: Int { productId }
    
    static func == (lhs: LowStockProduct, rhs: LowStockProduct) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
