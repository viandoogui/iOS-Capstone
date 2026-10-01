//
//  MockEmployeeRepository.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//
import Foundation

class MockEmployeeRepository: RepositoryProtocol<Employee>{
    
    func getAll() async throws -> [Employee] {
        employees
    }
    
    func insert(_ item: Employee) async throws -> Employee {
        employees.append(item)
        return item
    }
    
    func update(_ item: Employee) async throws {
        employees.removeAll(where: { $0.id == item.id})
        employees.append(item)
    }
    
    func delete(_ item: Employee) async throws {
        employees.removeAll(where: { $0.id == item.id})
    }
    func getById(_ id: Int) async throws -> Employee? {
        employees.first(where: { $0.id == id})
    }
    private var employees: [Employee] = [
        Employee(
            id: 101,
            firstName: "John",
            lastName: "Snow",
            title: nil,
            shift: "Full-time",
            department: "Engineering",
            hireDate: Date(),
            jobTitle: "Software Engineer",
            ),
        Employee(
            id: 102,
            firstName: "John",
            lastName: "Snow",
            title: nil,
            shift: "Full-time",
            department: "Engineering",
            hireDate: Date(),
            jobTitle: "Software Engineer",
            ),
        Employee(
            id: 103,
            firstName: "Jane",
            lastName: "Lou",
            title: "Ms.",
            shift: "Part-time",
            department: "HR",
            hireDate: Date(),
            jobTitle: "Talent Acquisition Specialist",
            ),
        Employee(
            id: 104,
            firstName: "Jake",
            lastName: "Smith",
            title: nil,
            shift: "Full-time",
            department: "Engineering",
            hireDate: Date(),
            jobTitle: "Mechanical Engineer",
            ),
        Employee(
            id: 105,
            firstName: "Jillian",
            lastName: "Truevale",
            title: nil,
            shift: "Full-time",
            department: "Sales",
            hireDate: Date(),
            jobTitle: "Target Metrics Specialist",
            ),
        Employee(
            id: 106,
            firstName: "Ian",
            lastName: "Paul",
            title: "Dr.",
            shift: "Full-time",
            department: "Research and Development",
            hireDate: Date(),
            jobTitle: "Head Researcher",
            )
        ]
}

