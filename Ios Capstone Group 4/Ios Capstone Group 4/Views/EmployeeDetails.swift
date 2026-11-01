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
        ScrollView {
            VStack(spacing: 0) {
                Text("Employee Details")
                    .font(.title)
                    .padding(10)
                HStack {
                    Spacer()
                    
                    VStack {
                        
                        VStack(spacing: 0) {
                            AccessibilityDetailItem("First Name:", employee.firstName, "Employee's first name is \(employee.firstName)")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Last Name:", employee.lastName, "Employee's last name is \(employee.lastName)")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Title:", employee.title ?? "none", "Employee's title is \(employee.title ?? "none")")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Shift:", employee.shift, "Employee's shift is \(employee.shift)")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Department:", employee.department, "Employee's department is \(employee.department)")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Date/Time of Hire:", employee.hireDate.formatted(), "Employee's date and time of hire is \(employee.hireDate.formatted())")
                                .padding(10)
                            
                            Divider()
                            
                            AccessibilityDetailItem("Job Title:", employee.jobTitle, "Employee's job title is \(employee.jobTitle)")
                                .padding(10)
                            
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(10)
                        
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
