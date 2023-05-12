//
//  RestApiNetworking.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

protocol RestApiNetworking {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension RestApiNetworking {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}
    
extension URLSession: RestApiNetworking{}
