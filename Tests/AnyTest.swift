//
//  AnyTest.swift
//  backendProject
//
//  Created by Peter Bruz on 15/02/2017.
//
//

import XCTest
import SwiftyJSON
@testable import GreenGurus

class AnyTest: XCTestCase {

    var x: Int!

    override func setUp() {
        super.setUp()
        x = 10
    }

    func checkX() {
        XCTAssert(x == 10)
    }
}
