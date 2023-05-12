//
//  UsersRepository.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

protocol UsersDataRepository {
    func getUsers(path: String) async throws -> [User]
}

struct UsersRepository: JsonDecoder {
    private let serviceManager: RestApiNetworkable
    private let offlineDataManager: OfflineDataManager
    
    init(serviceManager: RestApiNetworkable = RestApiManager(), offlineDataManager: OfflineDataManager = CoreRepository()) {
        self.serviceManager = serviceManager
        self.offlineDataManager = offlineDataManager
    }
    
    private func fetchUsersUrl(path: String) async throws -> [UserData] {
        do {
            let request = UsersRequest(path: path)
            let data = try await serviceManager.get(request:request)
            let lists = try decode(data:data, to: [UserData].self)
            return lists
        } catch {
            throw error
        }
    }
    private func fetchUser(path: String) async throws -> User {
        do {
            let request = UsersRequest(path: RestApiEndPoints.usersPath+"/"+path)
            let data = try await serviceManager.get(request:request)
            let list = try decode(data:data, to: User.self)
            return list
        } catch {
            throw error
        }
    }
    
}

extension UsersRepository: UsersDataRepository {
    
    func getUsers(path: String) async throws -> [User] {
      
        do {
            // Connecting to server to get users URLS
            let usersUrls = try await  fetchUsersUrl(path:path)
            
            // Connectiong server to get all users concurently
            let users =  try await withThrowingTaskGroup(of: User.self) { group -> [User] in
                var users: [User] = []
                
                for userUrl in usersUrls {
                    group.addTask {
                        return try await fetchUser(path: userUrl.login)
                    }
                }
                for try await user in group {
                    users.append(user)
                }
                return users
            }
            // If users are empty from server than read data from locally storage
            if users.isEmpty {
                let users =   offlineDataManager.fetchUsers().map {
                    $0.mapToUser()
                }
                return users
            }
            else {
                // updating data to local storage
                offlineDataManager.addUsers(users: users)
                return users
            }
            
        } catch {
            // if API fails to get data from server than reading lcoally data if local data is empty throwing error.
            let users = offlineDataManager.fetchUsers().map {
                $0.mapToUser()
            }
            if users.isEmpty {
                throw RestApiCallError.dataNotFound
            }
            return users
        }
    }
}
