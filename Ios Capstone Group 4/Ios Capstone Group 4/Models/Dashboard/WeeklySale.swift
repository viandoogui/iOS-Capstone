//
//  WeeklySales.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

struct WeeklySale: Codable, Hashable, Identifiable {
    let salesDate: Date
    let totalSales: Double
    let totalProfit: Double
    
    var id: Date {
        salesDate
    }
    
    static func == (lhs: WeeklySale, rhs: WeeklySale) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
