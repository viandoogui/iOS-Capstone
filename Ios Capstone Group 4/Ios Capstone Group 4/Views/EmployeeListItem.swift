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
        GridRow {
            Text("\(employee.firstName)")
            Text("\(employee.lastName)")
            Text("\(employee.department)")
        }
        
    }
}
