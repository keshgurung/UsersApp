//
//  JsonDecoder.swift
//  UsersApp
//
//  Created by Kesh Gurung on 09/05/2023.
//

import Foundation

protocol JsonDecoder {
    func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T
}

extension JsonDecoder {
    func decode<T: Decodable>(data: Data, to type: T.Type) throws -> T {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try jsonDecoder.decode(type, from: data)

        } catch {
            throw RestApiCallError.parsingError
        }
    }
}
