//
//  MockShiftsRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 11/1/26.
//

import Foundation

class MockShiftsRepository: RepositoryProtocol<DashboardEmployee>{
    
    func getAll() async throws -> [DashboardEmployee] {
        dashboardEmployees
    }
    
    func getById(_ id: Int) async throws -> DashboardEmployee? {
        dashboardEmployees.first(where: { $0.id == id})
    }
    
    private var dashboardEmployees: [DashboardEmployee] = [
        DashboardEmployee(employeeId: 1, firstName: "John", middleName: "Andrew", lastName: "Williams", suffix: nil, shift: "Day"),
        DashboardEmployee(employeeId: 1, firstName: "Jane", middleName: "Jillian", lastName: "Doe", suffix: "Jr.", shift: "Day"),
        DashboardEmployee(employeeId: 1, firstName: "Andy", middleName: "Bill", lastName: "Williams", suffix: nil, shift: "Night")
        ]
}
