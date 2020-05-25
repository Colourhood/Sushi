//
//  ExampleEndpoint.swift
//  SushiTests
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

import Sushi

struct ExampleJSONModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct ExampleEndpoint: EndpointModel {
    typealias Model = ExampleJSONModel

    var httpMethod: HTTPMethod = .GET
    var url: String = "https://jsonplaceholder.typicode.com/todos/1"
}
