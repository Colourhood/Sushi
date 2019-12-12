//
//  Endpoint.swift
//  Sushi
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

public protocol Endpoint {
    associatedtype Model: Codable

    var url: URL { get }
}
