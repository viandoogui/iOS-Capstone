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
                
                if viewModel.isLoading {
                    ProgressView("Loading orders...")
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)

                    Button("Try Again") {
                        Task {
                            await viewModel.loadOrders()
                        }
                    }
                }

                
                HStack {
                    TextField("Search Orders...", text: $viewModel.filter)
                        .textFieldStyle(.roundedBorder)
                      
                    Menu {
                        Button("None") {
                            viewModel.clearSort()
                            viewModel.refilterOrders()
                        }

                        Button("A - Z") {
                            viewModel.sortByAZ()
                            viewModel.selectedSort()
                        }

                        Button("Z - A") {
                            viewModel.sortByZA()
                            viewModel.selectedSort()
                        }
                    } label: {
                        Text("Sort By...")
                            .padding(12)
                            .background(Color.white, in: Capsule())
                            .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                    }
                }
                .padding(.horizontal, 20)
                
                VStack {
                    if viewModel.errorMessage.isEmpty {
                        VStack {
                            ScrollView {
                                if viewModel.matchingOrders.isEmpty &&
                                    viewModel.errorMessage.isEmpty &&
                                    !viewModel.isLoading {
                                    Text(viewModel.filter.isEmpty ? "No orders available." : "No matching orders found.")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                                ForEach(viewModel.matchingOrders) { order in
                                    OrderListItem(order: order, allOrders: viewModel.allOrders)

                                }
                            }
                            .refreshable {
                                viewModel.filter = ""
                                await viewModel.loadOrders()
                            }
                            .background(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .padding(10)
                        
                    }
                    
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(10)
                .navigationTitle("Order History")
                
            }
            .padding(.top, 20)
            .background(Color.cyan)
            .task {
                await viewModel.loadOrders()
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
                refilterOrders()
            }
        }

        var selectedSort: () -> Void = {}

        func refilterOrders() {
            matchingOrders = orders.filter { order in
                filter == "" ||
                order.storeName.lowercased().contains(filter.lowercased()) ||
                String(order.orderNumber).contains(filter)
            }

            selectedSort()
        }

        func clearSort() {
            selectedSort = {}
        }

        func sortByAZ() {
            selectedSort = {
                self.matchingOrders = self.matchingOrders.sorted(by: {
                    $0.storeName < $1.storeName
                })
            }
        }

        func sortByZA() {
            selectedSort = {
                self.matchingOrders = self.matchingOrders.sorted(by: {
                    $0.storeName > $1.storeName
                })
            }
        }
        
        var errorMessage = ""
        var isLoading = true

        private let repo: any RepositoryProtocol<Order>

        init(repository: any RepositoryProtocol<Order>) {
            self.repo = repository
        }

        func loadOrders() async {
            
            isLoading = true
            errorMessage = ""

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
                refilterOrders()
                
                isLoading = false

            } catch {
                errorMessage = "Couldn't load orders. Please try again."
                isLoading = false
            }
        }
    }
}

#Preview {
    OrderListView(repository: MockOrderRepository())
}

