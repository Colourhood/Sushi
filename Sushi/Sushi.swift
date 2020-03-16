//
//  HTTP.swift
//  Sushi
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

import Foundation

public struct Sushi {
    private let decoder = JSONDecoder()
    private let session = URLSession.shared

    public func request<E: Endpoint>(
        endpoint: E,
        success: ((E.Model) -> Void)? = nil,
        failure: ((Error) -> Void)? = nil) {

        session.dataTask(with: endpoint.urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let model: E.Model = try self.serializeJSON(endpoint: endpoint, data: data)
                    success?(model)
                } catch (let serializationError) {
                    failure?(serializationError)
                }
            }

            if let error = error {
                failure?(error)
            }
        }.resume()
    }


    private func serializeJSON<E: Endpoint>(endpoint: E, data: Data) throws -> E.Model {
        return try decoder.decode(E.Model.self, from: data)
    }
}
