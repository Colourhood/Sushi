//
//  HTTP.swift
//  Sushi
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

import Foundation

public struct Sushi {
    private let session = URLSession.shared

    public func request<E: EndpointModel>(
        endpoint: E,
        success: ((E.Model) -> Void)? = nil,
        failure: ((Error) -> Void)? = nil) {

        do {
            let request = try buildRequestURL(with: endpoint)
            handleRequest(request: request, endpoint: endpoint, success: success, failure: failure)
        } catch let error {
            failure?(error)
        }
    }

    // MARK: Internal Methods

    internal func handleRequest<E: EndpointModel>(
        request: URLRequest,
        endpoint: E,
        success: ((E.Model) -> Void)?,
        failure: ((Error) -> Void)?) {

        session.dataTask(with: request) { (data, response, error) in
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

    internal func buildRequestURL<E: EndpointModel>(with endpoint: E) throws -> URLRequest {
        guard let url = URL(string: endpoint.url) else { throw SushiErrors.urlBuilding }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.string

        return request
    }

    internal func serializeJSON<E: EndpointModel>(endpoint: E, data: Data) throws -> E.Model {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(E.Model.self, from: data)
        } catch DecodingError.dataCorrupted {
            throw SushiErrors.jsonDecoding
        }
    }
}
