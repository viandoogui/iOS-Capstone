//
//  MockOrderRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

import Foundation

class MockOrderRepository: RepositoryProtocol<Order>{
    func getAll() async throws -> [Order] {
        orders
    }
    
    func getById(_ id: Int) async throws -> Order? {
        orders.first(where: { $0.id == id})
    }
    
    func insert(_ item: Order) async throws -> Order {
        orders.append(item)
        return item
    }
    
    func update(_ item: Order) async throws {
        orders.removeAll(where: { $0.id == item.id})
        orders.append(item)
    }
    
    func delete(_ item: Order) async throws {
        orders.removeAll(where: { $0.id == item.id})
    }
    
    var orders: [Order] = [
        Order(id: 110562, businessEntityId: 1092, customerId: 29847, storeName: "Good Toys",
                      orderDate: Date(), contactFirstName: "Dave", contactLastName: "Hodgson",
                      orderNumber: 71774, productName: "ML Road Frame-W - Yellow, 48", orderQty: 1,
                      unitPrice: 356.898, lineTotal: 356.898, shipDate: Date()),

                Order(id: 110563, businessEntityId: 1092, customerId: 29847, storeName: "Good Toys",
                      orderDate: Date(), contactFirstName: "Dave", contactLastName: "Hodgson",
                      orderNumber: 71774, productName: "ML Road Frame-W - Yellow, 38", orderQty: 1,
                      unitPrice: 356.898, lineTotal: 356.898, shipDate: Date()),

                Order(id: 110564, businessEntityId: 1804, customerId: 30031, storeName: "Cycle Clearance",
                      orderDate: Date(), contactFirstName: "Alan", contactLastName: "Steiner",
                      orderNumber: 71775, productName: "Touring-1000 Blue, 46", orderQty: 1,
                      unitPrice: 1430.442, lineTotal: 1430.442, shipDate: Date()),

                Order(id: 110565, businessEntityId: 1804, customerId: 30031, storeName: "Cycle Clearance",
                      orderDate: Date(), contactFirstName: "Alan", contactLastName: "Steiner",
                      orderNumber: 71775, productName: "Front Brakes", orderQty: 3,
                      unitPrice: 63.9, lineTotal: 191.7, shipDate: Date()),

                Order(id: 110566, businessEntityId: 1804, customerId: 30031, storeName: "Cycle Clearance",
                      orderDate: Date(), contactFirstName: "Alan", contactLastName: "Steiner",
                      orderNumber: 71775, productName: "Short-Sleeve Classic Jersey, L", orderQty: 4,
                      unitPrice: 32.394, lineTotal: 129.576, shipDate: Date()),

                Order(id: 110567, businessEntityId: 1892, customerId: 30072, storeName: "West Side Mart",
                      orderDate: Date(), contactFirstName: "Andrea", contactLastName: "Thomsen",
                      orderNumber: 71776, productName: "Rear Brakes", orderQty: 1,
                      unitPrice: 63.9, lineTotal: 63.9, shipDate: Date()),

                Order(id: 110568, businessEntityId: 1892, customerId: 30072, storeName: "West Side Mart",
                      orderDate: Date(), contactFirstName: "Andrea", contactLastName: "Thomsen",
                      orderNumber: 71776, productName: "Mountain-200 Black, 42", orderQty: 2,
                      unitPrice: 1229.4, lineTotal: 2458.8, shipDate: Date()),

                Order(id: 110569, businessEntityId: 2011, customerId: 30115, storeName: "Bike World",
                      orderDate: Date(), contactFirstName: "Maria", contactLastName: "Lopez",
                      orderNumber: 71777, productName: "HL Mountain Frame - Black, 42", orderQty: 1,
                      unitPrice: 809.76, lineTotal: 809.76, shipDate: Date()),

                Order(id: 110570, businessEntityId: 2011, customerId: 30115, storeName: "Bike World",
                      orderDate: Date(), contactFirstName: "Maria", contactLastName: "Lopez",
                      orderNumber: 71777, productName: "Water Bottle - 30 oz.", orderQty: 6,
                      unitPrice: 2.994, lineTotal: 17.964, shipDate: Date()),

                Order(id: 110571, businessEntityId: 2150, customerId: 30188, storeName: "Pedal Pushers",
                      orderDate: Date(), contactFirstName: "Greg", contactLastName: "Walsh",
                      orderNumber: 71778, productName: "Sport-100 Helmet, Red", orderQty: 5,
                      unitPrice: 20.994, lineTotal: 104.97, shipDate: Date()),

                Order(id: 110572, businessEntityId: 2150, customerId: 30188, storeName: "Pedal Pushers",
                      orderDate: Date(), contactFirstName: "Greg", contactLastName: "Walsh",
                      orderNumber: 71778, productName: "Road-650 Red, 60", orderQty: 2,
                      unitPrice: 419.4, lineTotal: 838.8, shipDate: Date()),

                Order(id: 110573, businessEntityId: 2237, customerId: 30260, storeName: "Trail Blazers",
                      orderDate: Date(), contactFirstName: "Priya", contactLastName: "Nair",
                      orderNumber: 71779, productName: "Touring Tire Tube", orderQty: 10,
                      unitPrice: 4.99, lineTotal: 49.9, shipDate: Date())
            ]
}
