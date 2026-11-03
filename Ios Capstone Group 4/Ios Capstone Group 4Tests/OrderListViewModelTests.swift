//
//  OrderListViewModelTests.swift
//  Ios Capstone Group 4Tests
//
//  Created by user303024 on 10/19/26.
//

import Foundation
import Testing
@testable import Ios_Capstone_Group_4

@MainActor
struct OrderListViewModelTests {
    
    @Test func loadOrders() async {
        let repo = MockOrderRepository()
        let viewModel = OrderListView.ViewModel(repository: repo)
        
        await viewModel.loadOrders()
        
        #expect(viewModel.allOrders.count == 12)
        #expect(viewModel.orders.count == 6)
        
    }
    
    // TEST 2: Search orders by store name
    @Test func searchByStore() async {
        let repo = MockOrderRepository()
        let viewModel = OrderListView.ViewModel(repository: repo)
        
        await viewModel.loadOrders()
        
        viewModel.filter = "cycle"
        
        #expect(viewModel.matchingOrders.count == 1)
        #expect(viewModel.matchingOrders.first?.storeName == "Cycle Clearance")
    }
    
    // TEST 3: Search orders by order number
    @Test func searchByOrderNumber() async {
        let repo = MockOrderRepository()
        let viewModel = OrderListView.ViewModel(repository: repo)
        
        await viewModel.loadOrders()
        
        viewModel.filter = "71775"
        
        #expect(viewModel.matchingOrders.count == 1)
        #expect(viewModel.matchingOrders.first?.orderNumber == 71775)
    }
    
    @Test func orderDetailsTotal() async throws {
        let repo = MockOrderRepository()
        let allOrders = try await repo.getAll()
        
        let details = OrderDetails(
            orderNumber: 71775,
            orders: allOrders
        )
        
        #expect(details.matchingOrders.count == 3)
        #expect(String(format: "%.2f", details.total) == "1751.72")
    }
}
