//
//  EmployeeList.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/1/26.
//

import SwiftUI

struct EmployeeList: View {
    
    @State private var viewModel: ViewModel
    
    init(repository: any RepositoryProtocol<Employee>) {
        viewModel = ViewModel(repository: repository)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView("Loading employees...")
                        }

                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.white)

                            Button("Try Again") {
                                Task {
                                    await viewModel.loadEmployees()
                                }
                            }

                            .padding(12)
                            .background(Color.white, in: Capsule())
                            .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                        } else {

                            HStack {
                                TextField("Search Full Name...", text: $viewModel.filter)
                                    .padding(5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                Spacer()
                                Menu {
                                    Button("None") {
                                        viewModel.clearSort()
                                        viewModel.refilterEmployees()
                                    }
                                    Button("A - Z"){
                                        viewModel.sortByAZ()
                                        viewModel.selectedSort()
                                    }
                                    Button("Z - A"){
                                        viewModel.sortByZA()
                                        viewModel.selectedSort()
                                    }
                                }
                                label: {
                                    Text("Sort By...")
                                        .padding(12)
                                        .background(Color.white, in: Capsule())
                                        .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                                }
                            }
                            .padding(10)
                            
                            HStack {
                                TextField("Search Department...", text: $viewModel.departmentFilter)
                                    .padding(5)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            }
                            .padding(.horizontal, 10)
                            
                            ScrollView { Grid(horizontalSpacing: 0, verticalSpacing: 0){
                                HStack {
                                    GridRow {
                                        Text("First Name")
                                        Text("Last Name")
                                        Text("Department")
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding(5)

                                ForEach(viewModel.matchingEmployees) { employee in

                                    EmployeeListItem(employee: employee)
                                        .padding(10)
                                }
                                
                            }
                            }
                            .refreshable {
                                await viewModel.loadEmployees()
                            }
                            .background(Color.white)
                            .padding(15)
                        }
                        
                    }
                    .navigationTitle("Employee List")
                    .toolbarTitleDisplayMode(.inline)
                    .navigationDestination(for: Employee.self) { employee in
                        EmployeeDetails(employee: employee)
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(10)
                    
                    
                    Spacer()
                }
                .background(Color.cyan)
                .cornerRadius(20)
                .padding(0)
                
            }
            .frame(alignment: .top)
            .task {
                await viewModel.loadEmployees()
            }
            
        }
        
    }
    
}

extension EmployeeList {
    
    @Observable
    class ViewModel {
        private let repository: any RepositoryProtocol<Employee>
        
        init(repository: any RepositoryProtocol<Employee>) {
            self.repository = repository
        }
        
        var errorMessage: String = ""
        var isLoading = true
        
        var employees: [Employee] = [] {
            didSet {
                filter = ""
                selectedEmployee = nil
            }
        }
        
        var filter: String = "" {
            didSet {
                refilterEmployees()
            }
        }
        
        var departmentFilter: String = "" {
            didSet {
                refilterEmployees()
            }
        }

        
        func refilterEmployees() {
            matchingEmployees = employees.filter { employee in
                (filter == "" ||
                ("\(employee.firstName.lowercased()) \(employee.lastName.lowercased())"
                    .contains(filter.lowercased()) && filter != " "))
                && (departmentFilter == "" || employee.department.lowercased().contains( departmentFilter.lowercased())
                )
            }
            
            selectedSort()
        }
        
        var matchingEmployees: [Employee] = []
        
        var selectedEmployee: Employee? = nil
        
        func loadEmployees() async {

            isLoading = true
            errorMessage = ""

            do {
                employees = try await repository.getAll()
                isLoading = false

            } catch {
                errorMessage = "Couldn't load employees. Please try again."
                isLoading = false
            }
        }
        
        var selectedSort: () -> Void = {}
        
        func clearSort() {
            selectedSort = {}
        }
        
        func sortByAZ() {
            selectedSort = { self.matchingEmployees = self.matchingEmployees.sorted(by: {$0.firstName < $1.firstName}) }
        }
        
        func sortByZA() {
            selectedSort = { self.matchingEmployees = self.matchingEmployees.sorted(by: {$0.firstName > $1.firstName}) }
        }
        
    }
}

#Preview {
    EmployeeList(repository: MockEmployeeRepository())
}
