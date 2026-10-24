//
//  OrderListItem.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/23/26.
//

import SwiftUI

struct OrderListItem: View {
    let order: Order
    let allOrders: [Order]
    
    init(order: Order, allOrders: [Order]) {
        self.order = order
        self.allOrders = allOrders
    }
    
    var body: some View {
        NavigationLink(
            destination: OrderDetails(
                orderNumber: order.orderNumber,
                orders: allOrders
            )
        ) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Order #: \(order.orderNumber)")

                Text("Store: \(order.storeName)")

                Text("Date: \(order.orderDate.formatted(date: .numeric, time: .omitted))")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .border(Color.black, width: 1)
        }
        .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
    }
}
