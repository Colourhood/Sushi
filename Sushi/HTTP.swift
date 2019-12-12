//
//  HTTP.swift
//  Sushi
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

import Foundation

public struct HTTP<E: Endpoint> {
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    var endpoint: E

    public func request(success: ((E.Model) -> Void)? = nil,
                        failure: ((Error) -> Void)? = nil) {

        session.dataTask(with: endpoint.url) { (data, response, error) in
            if let data = data {
                do {
                    let model: E.Model = try self.serializeJSON(data: data)
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

    private func serializeJSON(data: Data) throws -> E.Model {
        return try decoder.decode(E.Model.self, from: data)
    }
}
