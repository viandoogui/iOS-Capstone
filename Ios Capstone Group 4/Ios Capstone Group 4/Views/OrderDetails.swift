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
            
            if let firstOrder = matchingOrders.first {
                
                Text("Order #: \(firstOrder.orderNumber)")
                Text("Store: \(firstOrder.storeName)")
                Text("Date: \(firstOrder.orderDate.formatted(date: .numeric, time: .omitted))")
                
                VStack {
                    
                    HStack {
                        Text("Product")
                            .frame(maxWidth: .infinity)
                        
                        Text("Qty")
                            .frame(width: 50)
                        
                        Text("Price")
                            .frame(width: 80)
                    }
                    .padding(5)
                    
                    ScrollView {
                        
                        ForEach(matchingOrders) { order in
                            
                            HStack {
                                Text(order.productName)
                                    .frame(maxWidth: .infinity)
                                
                                Divider()
                                
                                Text("\(order.orderQty)")
                                    .frame(width: 50)
                                
                                Divider()
                                
                                Text(
                                    String(
                                        format: "$%.2f",
                                        order.unitPrice
                                    )
                                )
                                .frame(width: 80)
                            }
                            .padding(8)
                            .border(Color.black, width: 1)
                        }
                    }
                    
                    Text(
                        String(
                            format: "Total: $%.2f",
                            total
                        )
                    )
                    .padding()
                }
                .background(Color.white)
                .padding(10)
                
            } else {
                
                Text("Order not found")
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .background(Color.cyan)
    }
}
