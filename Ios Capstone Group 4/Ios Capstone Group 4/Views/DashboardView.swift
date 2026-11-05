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
        self.productRepository = productRepository
        self.lowStockRepository = lowStockRepository
        self.shiftsRepository = shiftsRepository
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("Operational Dashboard")
                    .font(.largeTitle)
                NavigationLink("View Product Performance") {
                    ProductPerformanceView(repository: productRepository)
                }
                .buttonStyle(.borderedProminent)
                NavigationLink("View Low Stock") {
                    LowStockView(repository: lowStockRepository)
                }
                .buttonStyle(.borderedProminent)
                NavigationLink("View Employee Shifts") {
                    EmployeeShiftsView(repository: shiftsRepository)
                }
                .buttonStyle(.borderedProminent)
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
                    ForEach(viewModel.sales.sorted {
                        $0.salesDate > $1.salesDate
                    }.prefix(7)) { sale in
                        VStack {
                            Text(sale.salesDate.formatted(date: .numeric, time: .omitted))

                            Text("Sales: $\(sale.totalSales, specifier: "%.2f")")
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.cyan)
        .task {
            await viewModel.loadSales()
        }
    }
}

extension DashboardView {

    @Observable
    class ViewModel {

        var sales: [WeeklySale] = []
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
                isLoading = false

            } catch {
                print("Employee Shifts Error: \(error)")
                errorMessage = "Couldn't load weekly sales. Please try again."
                isLoading = false
            }
        }
    }
}

#Preview {
    DashboardView(
        repository: MockWeeklySalesRepository(),
        productRepository: MockBestWorstRepository(),
        lowStockRepository: MockLowStockRepository(),
        shiftsRepository: MockShiftsRepository()
    )
}
