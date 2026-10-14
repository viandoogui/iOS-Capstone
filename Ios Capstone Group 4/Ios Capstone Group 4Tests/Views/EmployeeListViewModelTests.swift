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
        
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "Bobby" }) == true)
    }
    
    @Test func searchAllUppercase() async {
        let repo = MockEmployeeRepository()
        let viewModel = EmployeeList.ViewModel(repository: repo)
        
        await viewModel.loadEmployees()
        
        viewModel.filter = "LOU"
        
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
        
        #expect(viewModel.matchingEmployees.contains(where: { $0.firstName == "Jillian" && $0.lastName == "Truevale" }) == true)
    }
    
}
