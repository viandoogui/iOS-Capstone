//
//  DashboardProduct.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

struct DashboardProduct: Codable, Hashable, Identifiable {
    let productId: Int
    let productName: String
    let unitsSold: Int
    let unitsInStock: Int
    
    var id: Int { productId }
    
    static func == (lhs: DashboardProduct, rhs: DashboardProduct) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
