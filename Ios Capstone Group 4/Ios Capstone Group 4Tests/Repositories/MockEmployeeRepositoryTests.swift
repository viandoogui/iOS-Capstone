//
//  MockEmployeeRepositoryTests.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

import Testing
@testable import Ios_Capstone_Group_4

@Test func mockEmployee_getAll() async throws {
    // Arrange
    let mockEmpRepo = await MockEmployeeRepository()
    // Act
    let count = try await mockEmpRepo.getAll().count
    // Assert
    #expect(count == 6)
}
