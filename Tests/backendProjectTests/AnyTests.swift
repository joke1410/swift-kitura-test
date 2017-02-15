//
//  AnyTest.swift
//  backendProject
//
//  Created by Peter Bruz on 15/02/2017.
//
//

import XCTest

class AnyTest: XCTestCase {

    var x: Int!

    override func setUp() {
        super.setUp()
        x = 10
    }

    func testX() {
        XCTAssert(x == 10)
    }
}
