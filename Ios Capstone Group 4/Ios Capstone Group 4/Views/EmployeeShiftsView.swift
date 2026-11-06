//
//  EmployeeShiftsView.swift
//  Ios Capstone Group 4
//
//  Created by user303024 on 11/5/26.
//

import Foundation
import SwiftUI

struct EmployeeShiftsView: View {

    @State private var viewModel: ViewModel

    init(repository: any RepositoryProtocol<DashboardEmployee>) {
        viewModel = ViewModel(repository: repository)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {

                Text("Employee Shifts")
                    .font(.title)

                if viewModel.isLoading {
                    ProgressView("Loading employees...")

                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)

                    Button("Try Again") {
                        Task {
                            await viewModel.loadEmployees()
                        }
                    }

                } else {
                    ForEach(viewModel.employees) { employee in
                        VStack {
                            Text("\(employee.firstName) \(employee.lastName)")
                            Text("Shift: \(employee.shift)")
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.loadEmployees()
        }
    }
}

extension EmployeeShiftsView {

    @Observable
    class ViewModel {

        var employees: [DashboardEmployee] = []
        var isLoading = true
        var errorMessage = ""

        private let repository: any RepositoryProtocol<DashboardEmployee>

        init(repository: any RepositoryProtocol<DashboardEmployee>) {
            self.repository = repository
        }

        func loadEmployees() async {
            isLoading = true
            errorMessage = ""

            do {
                employees = try await repository.getAll()
                isLoading = false
            } catch {
                errorMessage = "Couldn't load employee shifts. Please try again."
                isLoading = false
            }
        }
    }
}

#Preview {
    EmployeeShiftsView(repository: MockShiftsRepository())
}
