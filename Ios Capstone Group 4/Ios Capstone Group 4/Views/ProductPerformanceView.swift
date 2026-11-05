//
//  ProductPerformanceView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 11/5/26.
//

import Foundation
import SwiftUI

struct ProductPerformanceView: View {

    @State private var viewModel: ViewModel

    init(repository: any RepositoryProtocol<BestWorstProduct>) {
        viewModel = ViewModel(repository: repository)
    }

    var body: some View {
        VStack(spacing: 15) {

            Text("Product Performance")
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
                        Text("Units Sold: \(product.unitsSold)")
                    }
                }
            }
        }
        .padding()
        .task {
            await viewModel.loadProducts()
        }
    }
}

extension ProductPerformanceView {

    @Observable
    class ViewModel {

        var products: [BestWorstProduct] = []
        var isLoading = true
        var errorMessage = ""

        private let repository: any RepositoryProtocol<BestWorstProduct>

        init(repository: any RepositoryProtocol<BestWorstProduct>) {
            self.repository = repository
        }

        func loadProducts() async {
            isLoading = true
            errorMessage = ""

            do {
                products = try await repository.getAll()
                isLoading = false
            } catch {
                errorMessage = "Couldn't load products. Please try again."
                isLoading = false
            }
        }
    }
}

#Preview {
    ProductPerformanceView(repository: MockBestWorstRepository())
}
