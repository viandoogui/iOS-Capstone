//
//  DashboardProduct.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

struct DashboardEmployee: Codable, Hashable, Identifiable {
    let employeeId: Int
    let firstName: String
    let middleName: String?
    let lastName: String
    let suffix: String?
    let shift: String
    
    var id: Int { employeeId }
    
    static func == (lhs: DashboardEmployee, rhs: DashboardEmployee) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
