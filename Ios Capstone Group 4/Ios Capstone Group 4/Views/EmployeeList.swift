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
                        HStack {
                            TextField("Search Full Name...", text: $viewModel.filter)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5)
                            Spacer()
                            Button("Filter") {}
                                .padding(12)
                                .background(Color.white, in: Capsule())
                        }
                        .padding(10)
                        
                        ScrollView {                        Grid(horizontalSpacing: 0, verticalSpacing: 0){
                            
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
                        .background(Color.white)
                        .padding(20)
                        
                    }
                    .navigationTitle("Employee List")
                    .background(Color.blue)
                    .padding(10)
                    .cornerRadius(20)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button( action: {} ) {
                                Image(systemName: "arrowshape.turn.up.backward.fill")
                            }
                        }
                        ToolbarSpacer()
                        ToolbarItem() {
                            Button( action: {} ) {
                                Image(systemName: "house")
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .background(Color.cyan)
                .padding(10)
                
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
        
        var employees: [Employee] = [] {
            didSet {
                filter = ""
                selectedEmployee = nil
            }
        }
        
        var filter: String = "" {
            didSet {
                matchingEmployees = employees.filter { employee in
                    filter == "" ||
                    "\(employee.firstName.lowercased()) \(employee.lastName.lowercased())"
                        .contains(filter.lowercased())
                }
                
            }
        }
        
        var matchingEmployees: [Employee] = []
        
        var selectedEmployee: Employee? = nil
        
        func loadEmployees() async {
            do {
                employees = try await repository.getAll()
            }
            catch {
                errorMessage = "\(error)"
            }
            
        }
        
    }
}

#Preview {
    EmployeeList(repository: MockEmployeeRepository())
}
