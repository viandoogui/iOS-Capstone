//
//  OrderListView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 10/9/26.
//

import SwiftUI

struct OrderListView: View {
    
    @State private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            
            Text("Order History")
                .font(.largeTitle)
            
            VStack {
                
                HStack {
                    TextField("Search Orders...", text: $viewModel.filter)
                        .textFieldStyle(.roundedBorder)
                        .padding(20)
                    
                    Button("Filter") {
                        
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                
                VStack {
                    
                    HStack {
                        Text("Order #")
                            .frame(width: 80)
                        
                        Text("Store")
                            .frame(maxWidth: .infinity)
                        
                        Text("Date")
                            .frame(width: 90)
                    }
                    .padding(5)
                    
                    ScrollView {
                        
                        ForEach(viewModel.matchingOrders) { order in
                            
                            NavigationLink(
                                destination: OrderDetails(
                                    orderNumber: order.orderNumber,
                                    orders: viewModel.allOrders
                                )
                            ) {
                                
                                HStack {
                                    
                                    Text("\(order.orderNumber)").frame(width: 80)
                                    
                                    Divider()
                                    
                                    Text(order.storeName).frame(maxWidth: .infinity)
                                    
                                    Divider()
                                    
                                    Text(
                                        order.orderDate.formatted(
                                            date: .numeric,
                                            time: .omitted
                                        )
                                    )
                                    .frame(width: 90)
                                }
                                .padding(8)
                                .border(Color.black, width: 1)
                            }
                        }
                    }
                    .background(Color.white)
                    .padding(10)
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(10)
                
                Spacer()
            }
            .padding(.top, 20)
            .background(Color.cyan)
            .task {
                await viewModel.loadOrders()
            }
        }
    }
}

extension OrderListView {
    
    @Observable
    class ViewModel {
        
        var orders: [Order] = []
        var allOrders: [Order] = []
        var matchingOrders: [Order] = []
        var filter: String = "" {
            didSet {
                matchingOrders = orders.filter { order in
                    filter == "" ||
                    order.storeName.lowercased().contains(filter.lowercased()) ||
                    String(order.orderNumber).contains(filter)
                }
            }
        }
        
        var errorMessage = ""
        
        var mockRepo = MockOrderRepository()
        
        func loadOrders() async {
            
            do {
                let loadedOrders = try await mockRepo.getAll()
                allOrders = loadedOrders
                
                var uniqueOrders: [Order] = []
                
                for order in loadedOrders {
                    if !uniqueOrders.contains(where: {
                        $0.orderNumber == order.orderNumber
                    }) {
                        uniqueOrders.append(order)
                    }
                }
                
                orders = uniqueOrders
                matchingOrders = uniqueOrders
                
            } catch {
                errorMessage = "Error loading orders"
            }
        }
    }
}
