//
//  CoreDataRepository.swift
//  UsersApp
//
//  Created by Kesh Gurung on 10/05/2023.
//

import Foundation
import SwiftUI

protocol OfflineDataManager {
    func addUsers(users: [User])
    func fetchUsers() -> [UserEntity]
    func deleteUsers()
}

struct CoreRepository: OfflineDataManager {
    func addUsers(users: [User]) {
        DataController.shared.deleteUsers()
        DataController.shared.addUsers(users: users)
    }
    func fetchUsers() -> [UserEntity] {
        let lists = DataController.shared.fetchUsers() ?? []
        return lists
    }
    func deleteUsers() {
        DataController.shared.deleteUsers()
    }
}
