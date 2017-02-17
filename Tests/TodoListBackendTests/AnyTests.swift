//
//  AnyTest.swift
//  TodoListBackend
//
//  Created by Peter Bruz on 15/02/2017.
//
//

import XCTest

class AnyTests: XCTestCase {

    var x: Int!

    override func setUp() {
        super.setUp()
        x = 10
    }

    func testX() {
        XCTAssert(x == 10)
    }
}

extension AnyTests {
    static var allTests : [(String, (AnyTests) -> () throws -> Void)] {
        return [
            ("testX", testX),
        ]
    }
}
