//
//  UserViewModelTest.swift
//  UsersAppTests
//
//  Created by Kesh Gurung on 12/05/2023.
//

import XCTest
@testable import UsersApp

final class UserViewModelTest: XCTestCase {
    
    var mockUserRepository: MockUserRepository!
    var userViewModel: UserViewModel!

    @MainActor override func setUp() {
        mockUserRepository = MockUserRepository()
        userViewModel = UserViewModel(repository: mockUserRepository)
    }
    
    override func tearDown() {
        mockUserRepository = nil
        userViewModel = nil
    }
   
    //when user list is not empty
    func testGetUserWhenListIsNotEmpty() async {
        
        // Given
        mockUserRepository.enqueuResponse(users: [User.mockUser()])
        
        // When
        await userViewModel.getUsersList(path: "UserAPIResponseData")
    
        // Then
        let empList = await userViewModel.users
        XCTAssertEqual(empList.count, 1)
        XCTAssertEqual(empList.first?.name, "Tom Preston-Werner")

        let viewState = await userViewModel.viewState
        XCTAssertEqual(viewState, .loaded)
    }
    
    
    //when user list is empty
    func testGetSchoolWhenListIsEmpty() async {
        
        // Given
        mockUserRepository.enqueuResponse(users: [])
        
        // When
        await userViewModel.getUsersList(path: "UserAPIResponseData")
        
        // Then

        let empList = await userViewModel.users
        XCTAssertEqual(empList.count, 0)
        let viewState = await userViewModel.viewState
        XCTAssertEqual(viewState, .emptyView)
    }
    
    
    //when repository throws error for getUsers
    func testGetSchoolWhenRepositoryThrowsError() async {
        
        // Given
        mockUserRepository.enqueuError(error: RestApiCallError.apiError)
        
        // When
        await userViewModel.getUsersList(path: "SchoolAPIResponseData")
        
        // Then
        let empList = await userViewModel.users
        XCTAssertEqual(empList.count, 0)
        let viewState = await userViewModel.viewState
        XCTAssertEqual(viewState, .error)
    }
}


