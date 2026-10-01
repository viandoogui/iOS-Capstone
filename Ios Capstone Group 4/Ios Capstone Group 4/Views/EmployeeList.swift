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
                VStack() {
                    HStack(){
                        TextField("Search Full Name...", text: $viewModel.filter)
                            .padding(5)
                        Spacer()
                        Button("Filter") {}
                        .padding(12)
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 2)
                        )
                    }
                    .padding(2)
                    
                    Grid(horizontalSpacing: 0, verticalSpacing: 0){
                        GridRow {
                            Text("First Name")
                            Text("Last Name")
                            Text("Department")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .border(Color.black, width: 0.2)
                        
                        
                        ForEach(viewModel.matchingEmployees) { employee in
                            EmployeeListItem(employee: employee)
                            
                                .onTapGesture {}
                                .frame(maxWidth: .infinity, maxHeight: 50)
                            
                        }
                        .background(Color.blue.opacity(0.7))
                        .border(Color.black, width: 0.2)
                        
                    }
                    .background(Color.gray.opacity(0.2))
                    .border(Color.black, width: 0.2)
                }
                .navigationTitle("Employee List")
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
            
            .padding(10)
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
