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
        VStack {
            Text("Employee Details")
                .font(.largeTitle)
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
                .padding(2)
                .background(Color.blue)
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding(10)
            .frame(maxWidth: .infinity)

        }
        .padding(.top, 20)
        .background(Color.cyan)
    }
    
}

#Preview {
    EmployeeDetails(employee: Employee(id: 0, firstName: "Mc", lastName: "Donalds", title: "Burger King", shift: "Night", department: "Kitchen", hireDate: Date(), jobTitle: "Chef"))
}
