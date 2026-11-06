//
//  DashboardView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 11/4/26.
//

import Foundation
import SwiftUI

struct DashboardView: View {

    @State private var viewModel: ViewModel
    @State private var productViewModel: ProductPerformanceView.ViewModel
    @State private var lowStockViewModel: LowStockView.ViewModel
    @State private var shiftsViewModel: EmployeeShiftsView.ViewModel

    private let productRepository: any RepositoryProtocol<BestWorstProduct>
    private let lowStockRepository: any RepositoryProtocol<LowStockProduct>
    private let shiftsRepository: any RepositoryProtocol<DashboardEmployee>

    init(
        repository: any RepositoryProtocol<WeeklySale>,
        productRepository: any RepositoryProtocol<BestWorstProduct>,
        lowStockRepository: any RepositoryProtocol<LowStockProduct>,
        shiftsRepository: any RepositoryProtocol<DashboardEmployee>
    ) {
        viewModel = ViewModel(repository: repository)

        productViewModel = ProductPerformanceView.ViewModel(
            repository: productRepository
        )

        lowStockViewModel = LowStockView.ViewModel(
            repository: lowStockRepository
        )

        shiftsViewModel = EmployeeShiftsView.ViewModel(
            repository: shiftsRepository
        )

        self.productRepository = productRepository
        self.lowStockRepository = lowStockRepository
        self.shiftsRepository = shiftsRepository
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("Operational Dashboard")
                    .font(.largeTitle)

                // Weekly Sales

                Text("Latest 7 Sales Days")
                    .font(.headline)

                if viewModel.isLoading {
                    ProgressView("Loading weekly sales...")

                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)

                    Button("Try Again") {
                        Task {
                            await viewModel.loadSales()
                        }
                    }

                } else {
                    Text("7-Day Sales Total: $\(viewModel.latestSalesTotal, specifier: "%.2f")")
                        .font(.headline)

                    ForEach(viewModel.sales.sorted {
                        $0.salesDate > $1.salesDate
                    }.prefix(7)) { sale in

                        VStack {
                            Text(sale.salesDate.formatted(
                                date: .numeric,
                                time: .omitted
                            ))

                            Text("Sales: $\(sale.totalSales, specifier: "%.2f")")
                        }
                    }
                }

                // Product Performance

                Text("Strong and Weak Products")
                    .font(.headline)

                if productViewModel.isLoading {
                    ProgressView("Loading products...")

                } else if !productViewModel.errorMessage.isEmpty {
                    Text("Product summary unavailable.")

                } else if productViewModel.products.isEmpty {
                    Text("No product information available.")

                } else {
                    ForEach(productViewModel.products) { product in
                        Text("\(product.productName): \(product.unitsSold) units sold")
                    }
                }

                NavigationLink("View Product Performance") {
                    ProductPerformanceView(repository: productRepository)
                }
                .buttonStyle(.borderedProminent)

                // Low Stock

                Text("Low Stock")
                    .font(.headline)

                if lowStockViewModel.isLoading {
                    ProgressView("Loading low stock...")

                } else if !lowStockViewModel.errorMessage.isEmpty {
                    Text("Low stock summary unavailable.")

                } else {
                    Text("Low Stock Products: \(lowStockViewModel.products.count)")
                }

                NavigationLink("View Low Stock") {
                    LowStockView(repository: lowStockRepository)
                }
                .buttonStyle(.borderedProminent)

                // Employee Shifts

                Text("Employee Shifts")
                    .font(.headline)

                if shiftsViewModel.isLoading {
                    ProgressView("Loading employees...")

                } else if !shiftsViewModel.errorMessage.isEmpty {
                    Text("Employee shifts unavailable.")

                } else {
                    Text("Employees with Shifts: \(shiftsViewModel.employees.count)")

                    ForEach(shiftsViewModel.employees.prefix(3)) { employee in
                        Text("\(employee.firstName) \(employee.lastName): \(employee.shift)")
                    }
                }

                NavigationLink("View Employee Shifts") {
                    EmployeeShiftsView(repository: shiftsRepository)
                }
                .buttonStyle(.borderedProminent)

            }
            .padding()
        }
        .background(Color.cyan)
        .task {
            await viewModel.loadSales()
            await productViewModel.loadProducts()
            await lowStockViewModel.loadProducts()
            await shiftsViewModel.loadEmployees()
        }
    }
}

// Weekly Sales ViewModel

extension DashboardView {

    @Observable
    class ViewModel {

        var sales: [WeeklySale] = []
        var latestSalesTotal: Double = 0
        var isLoading = true
        var errorMessage = ""

        private let repository: any RepositoryProtocol<WeeklySale>

        init(repository: any RepositoryProtocol<WeeklySale>) {
            self.repository = repository
        }

        func loadSales() async {
            isLoading = true
            errorMessage = ""

            do {
                sales = try await repository.getAll()

                latestSalesTotal = 0

                for sale in sales.sorted(by: {
                    $0.salesDate > $1.salesDate
                }).prefix(7) {
                    latestSalesTotal += sale.totalSales
                }

                isLoading = false

            } catch {
                errorMessage = "Couldn't load weekly sales. Please try again."
                isLoading = false
            }
        }
    }
}

// Dashboard Preview

#Preview {
    DashboardView(
        repository: MockWeeklySalesRepository(),
        productRepository: MockBestWorstRepository(),
        lowStockRepository: MockLowStockRepository(),
        shiftsRepository: MockShiftsRepository()
    )
}
