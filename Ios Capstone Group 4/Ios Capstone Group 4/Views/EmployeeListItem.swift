//
//  EmployeeListItem.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/1/26.
//

import SwiftUI

struct EmployeeListItem: View {
    let employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    var body: some View {
        NavigationLink(destination: EmployeeDetails(employee: employee)) {
            HStack {
                GridRow {
                    Text("\(employee.firstName)")
                    Text("\(employee.lastName)")
                    Text("\(employee.department)")
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(Color(red: 0.0, green: 0.1, blue: 0.6))
                .padding(5)
            }
            
        }
        .border(Color.black, width: 1)
        .background {
            HStack {
                Spacer()
                Divider().gridCellUnsizedAxes(.vertical)
                Spacer()
                Divider().gridCellUnsizedAxes(.vertical)
                Spacer()
            }
            .padding(5)
        }
        .accessibilityLabel("Employee \(employee.firstName) \(employee.lastName) in the \(employee.department) department")
        
    }
}
