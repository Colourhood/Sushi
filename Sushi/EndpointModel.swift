//
//  Endpoint.swift
//  Sushi
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

public enum HTTPMethod: String {
    case GET, POST

    var string: String {
        return self.rawValue
    }
}

public protocol EndpointModel {
    associatedtype Model: Codable

    var httpMethod: HTTPMethod { get }
    var url: String { get }
}
