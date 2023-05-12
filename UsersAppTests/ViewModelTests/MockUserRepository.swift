//
//  MockUserRepository.swift
//  UsersAppTests
//
//  Created by Kesh Gurung on 12/05/2023.
//

import Foundation
@testable import UsersApp

class MockUserRepository: UsersDataRepository {
    private var users: [User] = []
    private var error: RestApiCallError?
    
    func enqueuResponse(users: [User]) {
        self.users = users
    }
    func enqueuError(error: RestApiCallError) {
        self.error = error
    }
    
    func getUsers(path: String) async throws -> [UsersApp.User] {
        if error != nil {
            throw error!
        }
        return users
    }
}
