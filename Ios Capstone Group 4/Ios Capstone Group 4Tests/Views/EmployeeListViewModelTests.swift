//
//  EmployeeListViewModelTests.swift
//  Ios Capstone Group 4
//
//  Created by user302959 on 10/14/26.
//

import Testing
@testable import Ios_Capstone_Group_4

@MainActor
struct EmployeeListViewModelTests {
    
    @Test func searchLetter() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "J"
        
        #expect(viewModel.matchingEmployees.count == 4)
    }
    
    @Test func searchSubstring() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "Ja"
        
        #expect(viewModel.matchingEmployees.count == 2)
    }
    
    @Test func searchAllLowercase() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "bobby"
        
        #expect(viewModel.matchingEmployees.count == 1)
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "Bobby" }) == true)
    }
    
    @Test func searchAllUppercase() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "LOU"
        
        #expect(viewModel.matchingEmployees.count == 1)
        #expect(viewModel.matchingEmployees.contains(where: { $0.lastName == "Lou" }) == true)
    }
    
    @Test func searchSpace() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = " "
        
        #expect(viewModel.matchingEmployees.count == 0)
    }
    
    @Test func searchSplitFullName() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "ian True"
        
        #expect(viewModel.matchingEmployees.count == 1)
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "Jillian" && $0.lastName == "Truevale" }) == true)
    }
    
    @Test func searchDirectory() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.departmentFilter = "Engineering"
        
        #expect(viewModel.matchingEmployees.count == 2)
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "John" && $0.lastName == "Snow" }) == true)
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "Jake" && $0.lastName == "Smith" }) == true)
    }
    
    @Test func searchNameAndDirectory() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "John"
        viewModel.departmentFilter = "Engineering"
        
        #expect(viewModel.matchingEmployees.count == 1)
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "John" && $0.lastName == "Snow" }) == true)
    }
    
    @Test func sortAZ() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.sortByAZ()
        viewModel.filter = ""
        
        let names = viewModel.matchingEmployees.map { $0.firstName }
        
        #expect(names == ["Bobby", "Ian", "Jake", "Jane", "Jillian", "John"])
    }
    
    @Test func searchLetterAndSortAZ() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.sortByAZ()
        viewModel.filter = "J"
        
        let names = viewModel.matchingEmployees.map { $0.firstName }
        
        #expect(names == ["Jake", "Jane", "Jillian", "John"])
    }
    
    @Test func searchLetterDepartmentAndSortAZ() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.sortByAZ()
        viewModel.filter = "J"
        viewModel.departmentFilter = "Engineering"
        
        let names = viewModel.matchingEmployees.map { $0.firstName }
        
        #expect(names == ["Jake", "John"])
    }
    
    @Test func sortZA() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.sortByZA()
        viewModel.filter = ""
        
        let names = viewModel.matchingEmployees.map { $0.firstName }
        
        #expect(names == ["John", "Jillian", "Jane", "Jake", "Ian", "Bobby"])
    }
    
    @Test func searchLetterAndSortZA() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.sortByZA()
        viewModel.filter = "J"
        
        let names = viewModel.matchingEmployees.map { $0.firstName }
        
        #expect(names == ["John", "Jillian", "Jane", "Jake"])
    }
}
