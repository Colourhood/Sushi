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

struct ExampleEndpoint: Endpoint {
    typealias Model = ExampleJSONModel

    var http: HTTPTypes = .GET
    var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!

        return URLRequest(url: url)
    }
}
