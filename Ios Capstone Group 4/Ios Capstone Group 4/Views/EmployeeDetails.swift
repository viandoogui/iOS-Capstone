//
//  EmployeeDetails.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/1/26.
//

import SwiftUI

struct EmployeeDetails: View {
    var employee: Employee
    
    var body: some View {
        @Bindable var empBinding = employee
        ScrollView {
            VStack(spacing: 0) {
                Text("Employee Details")
                    .font(.title)
                    .padding(10)
                HStack {
                    Spacer()
                    VStack {
                        TextField("First Name", text: $empBinding.firstName)
                            .padding(20)
                            .textFieldStyle(.roundedBorder)
                        TextField("Last Name", text: $empBinding.lastName)
                            .padding(20)
                            .textFieldStyle(.roundedBorder)
                        TextField("Title", text: Binding<String>(
                            get: { $empBinding.title.wrappedValue ?? "" },
                            set: { $empBinding.title.wrappedValue = $0 }
                        ))
                        .padding(20)
                        .textFieldStyle(.roundedBorder)
                        TextField("Shift", text: $empBinding.shift)
                            .padding(20)
                            .textFieldStyle(.roundedBorder)
                        TextField("Department", text: $empBinding.department)
                            .padding(20)
                            .textFieldStyle(.roundedBorder)
                        HStack {
                            Text(employee.hireDate.formatted())
                            Spacer()
                        }
                        .padding(20)
                        TextField("Job Title", text: $empBinding.jobTitle)
                            .padding(20)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                
            }
            .background(Color.cyan)
            .cornerRadius(20)
            .padding(10)
            .frame(maxWidth: .infinity)
        }
        
    }
    
}

#Preview {
    EmployeeDetails(employee: Employee(id: 0, firstName: "Mc", lastName: "Donalds", title: "Burger King", shift: "Night", department: "Kitchen", hireDate: Date(), jobTitle: "Chef"))
}
