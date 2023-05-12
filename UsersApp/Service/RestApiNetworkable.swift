//
//  RestApiNetworkable.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

protocol RestApiNetworkable {
    func get(request: Requestable) async throws -> Data
}
