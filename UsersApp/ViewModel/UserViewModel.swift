//
//  UserViewModel.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

protocol UserViewModelType: ObservableObject {
    func getUsersList(path: String) async
}

enum ViewStates {
    case loading
    case error
    case loaded
    case emptyView
}

@MainActor
final class UserViewModel {
    @Published private(set) var viewState: ViewStates = .loading
    private(set) var users: [User] = []
    private let repository: UsersDataRepository
    init(repository: UsersDataRepository = UsersRepository()) {
        self.repository = repository
    }
}

extension UserViewModel: UserViewModelType {
    func getUsersList(path: String) async {
        viewState = .loading
        do {
            users = try await repository.getUsers(path: path)
           
            if users.isEmpty {
                viewState = .emptyView
            } else {
                viewState = .loaded
            }
        } catch {
            self.viewState = .error
        }
    }
}
