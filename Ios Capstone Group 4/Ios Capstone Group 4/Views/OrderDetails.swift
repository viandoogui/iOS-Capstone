//
//  OrderDetails.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 10/9/26.
//

import SwiftUI

struct OrderDetails: View {
    
    let orderNumber: Int
    let orders: [Order]
    
    var matchingOrders: [Order] {
        orders.filter { order in
            order.orderNumber == orderNumber
        }
    }
    
    var total: Double {
        var sum = 0.0
        
        for order in matchingOrders {
            sum += order.lineTotal
        }
        
        return sum
    }
    
    var body: some View {
        
        VStack {
            
            Text("Order Details")
                .font(.largeTitle)
            Spacer()
            if let firstOrder = matchingOrders.first {
                
                VStack {
                    HStack {
                        Text("Order #: \(firstOrder.orderNumber)")
                        Text(
                            String(
                                format: "Total: $%.2f",
                                total
                            )
                        )
                    }
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .padding(.horizontal, 10)
                    .padding(.top, 5)

                    HStack {
                        Text("Store: \(firstOrder.storeName)")
                        Text("Date: \(firstOrder.orderDate.formatted(date: .numeric, time: .omitted))")
                    }
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 5)

                }
                .background(Color.blue)
                .cornerRadius(10)
                
                
                
                VStack {
                    ScrollView {
                        ForEach(matchingOrders) { order in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(order.productName)

                                Text("Quantity: \(order.orderQty)")

                                Text(
                                    String(
                                        format: "Unit Price: $%.2f",
                                        order.unitPrice
                                    )
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .border(Color.black, width: 1)
                        }
                    }

                    
                   
                }
                .background(Color.white)
                .padding(10)
                
            } else {
                
                Text("Order not found")
            }
        
        }
        .background(Color.cyan)
        
        
    }
}
