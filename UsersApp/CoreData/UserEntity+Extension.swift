//
//  UserEntity+Extension.swift
//  UsersApp
//
//  Created by MAC on 11/05/23.
//

import Foundation


extension UserEntity {
    func mapToUser() -> User {
        return User(id: Int(id), name: name, avatarUrl: avatarUrl ?? "", company:company , email: email, twitterUsername: twitterUsername)
    }
}
