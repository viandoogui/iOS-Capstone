//
//  MockWeeklySalesRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

class MockWeeklySalesRepository: RepositoryProtocol<WeeklySale>{
    
    func getAll() async throws -> [WeeklySale] {
        weeklySales
    }
    
    func getById(_ id: Date) async throws -> WeeklySale? {
        weeklySales.first(where: { $0.id == id})
    }
    
    private var weeklySales: [WeeklySale] = [
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-26T00:00:00Z")!, totalSales: 1250.50, totalProfit: 687.78),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-27T00:00:00Z")!, totalSales: 1840.25, totalProfit: 1012.14),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-28T00:00:00Z")!, totalSales: 1560.75, totalProfit: 858.41),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-29T00:00:00Z")!, totalSales: 2125.00, totalProfit: 1168.75),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-30T00:00:00Z")!, totalSales: 2450.80, totalProfit: 1347.94),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-10-31T00:00:00Z")!, totalSales: 2890.40, totalProfit: 1589.72),
            WeeklySale(salesDate: ISO8601DateFormatter().date(from: "2026-11-01T00:00:00Z")!, totalSales: 1950.65, totalProfit: 1072.86)
        ]
}

