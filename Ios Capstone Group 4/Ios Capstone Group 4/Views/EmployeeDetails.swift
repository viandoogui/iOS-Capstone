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
                    VStack(spacing: 20) {
                        VStack(spacing: 0) {
                            Text("First Name:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("First Name", text: $empBinding.firstName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Last Name:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("Last Name", text: $empBinding.lastName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Title:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("Title", text: Binding<String>(
                                get: { $empBinding.title.wrappedValue ?? "" },
                                set: { $empBinding.title.wrappedValue = $0 }
                            ))
                            .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Shift:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("Shift", text: $empBinding.shift)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            Text("Department:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("Department", text: $empBinding.department)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Date/Time of Hire:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            HStack {
                                Text(employee.hireDate.formatted())
                                Spacer()
                            }
                            .foregroundStyle(Color.white)
                            .font(.headline)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Job Title:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 5)
                            TextField("Job Title", text: $empBinding.jobTitle)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        
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
