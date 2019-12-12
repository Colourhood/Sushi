//
//  SushiTests.swift
//  SushiTests
//
//  Created by Andrei Villasana on 12/11/19.
//  Copyright © 2019 Andrei Villasana. All rights reserved.
//

import XCTest
@testable import Sushi

class SushiTests: XCTestCase {

    var endpoint = ExampleEndpoint()
    var http: HTTP<ExampleEndpoint>!

    override func setUp() {
        http = HTTP(endpoint: endpoint)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let expectation = XCTestExpectation(description: "Fetch data")

        http.request(success: { (data) in
            XCTAssertNotNil(data, "We received data: \(data)")
            expectation.fulfill()
        }, failure: { (error) in
            XCTFail("Failed request \(error)")
        })

        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            testExample()
        }
    }

}
