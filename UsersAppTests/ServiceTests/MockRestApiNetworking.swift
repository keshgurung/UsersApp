//
//  MockRestApiNetworking.swift
//  UsersAppTests
//
//  Created by Kesh Gurung on 10/05/2023.
//

import Foundation
@testable import UsersApp

class MockRestApiNetworking: RestApiNetworking {
    var mockData: Data!
    var mockResponse: URLResponse!
    var error: Error?

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if error != nil {
            throw error!
        }
        return (mockData, mockResponse)
    }
}
