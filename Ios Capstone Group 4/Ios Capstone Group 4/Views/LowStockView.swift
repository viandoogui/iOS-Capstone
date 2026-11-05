//
//  LowStockView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 11/5/26.
//

import Foundation
import SwiftUI

struct LowStockView: View {

    @State private var viewModel: ViewModel

    init(repository: any RepositoryProtocol<LowStockProduct>) {
        viewModel = ViewModel(repository: repository)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("Low Stock Products")
                    .font(.title)

                if viewModel.isLoading {
                    ProgressView("Loading products...")

                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)

                    Button("Try Again") {
                        Task {
                            await viewModel.loadProducts()
                        }
                    }
                } else {
                    ForEach(viewModel.products) { product in
                        VStack {
                            Text(product.productName)
                            Text("In Stock: \(product.stockLevel)")
                            Text("Reorder Point: \(product.reorderPoint)")
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.loadProducts()
        }
    }
}

extension LowStockView {

    @Observable
    class ViewModel {

        var products: [LowStockProduct] = []
        var isLoading = true
        var errorMessage = ""

        private let repository: any RepositoryProtocol<LowStockProduct>

        init(repository: any RepositoryProtocol<LowStockProduct>) {
            self.repository = repository
        }

        func loadProducts() async {
            isLoading = true
            errorMessage = ""

            do {
                products = try await repository.getAll()
                isLoading = false
            } catch {
                errorMessage = "Couldn't load low stock products. Please try again."
                isLoading = false
            }
        }
    }
}

#Preview {
    LowStockView(repository: MockLowStockRepository())
}
