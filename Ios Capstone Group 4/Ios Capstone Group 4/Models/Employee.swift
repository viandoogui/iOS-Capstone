//
//  EmployeeModel.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

import Foundation

@Observable
class Employee: Identifiable, Hashable, Codable {
    let id: Int
    var firstName: String
    var lastName: String
    var title: String?
    var shift: String
    var department: String
    var hireDate: Date
    var jobTitle: String
    
    init(id: Int, firstName: String, lastName: String, title: String?, shift: String, department: String, hireDate: Date, jobTitle: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
        self.shift = shift
        self.department = department
        self.hireDate = hireDate
        self.jobTitle = jobTitle
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
