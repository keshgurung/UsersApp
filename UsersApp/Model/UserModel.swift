//
//  UserModel.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

struct UserData: Decodable {
    let login: String
    let url: String
}

struct User: Decodable, Identifiable {
    let id: Int
    let name: String?
    let avatarUrl: String
    let company: String?
    let email: String?
    let twitterUsername: String?
}

extension User {
    static func mockUser() -> User {
        return User(id: 1, name: "Tom Preston-Werner", avatarUrl: "mark@url", company: "markCompany", email: "mark@email.com", twitterUsername: "mark123")
    }
}

