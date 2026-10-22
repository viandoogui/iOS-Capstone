//
//  OrderListView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 10/9/26.
//

import SwiftUI

struct OrderListView: View {
    @State private var viewModel: ViewModel
    
    init(repository: any RepositoryProtocol<Order>) {
        viewModel = ViewModel(repository: repository)
    }
    
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
                    ScrollView {
                        ForEach(viewModel.matchingOrders) { order in
                            NavigationLink(
                                destination: OrderDetails(
                                    orderNumber: order.orderNumber,
                                    orders: viewModel.allOrders
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
                        }
                    }
                    .refreshable {
                        viewModel.filter = ""
                        await viewModel.loadOrders()
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
        private let repo: any RepositoryProtocol<Order>
        
        init(repository: any RepositoryProtocol<Order>) {
            self.repo = repository
        }
        
        func loadOrders() async {
            
            do {
                let loadedOrders = try await repo.getAll()
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
