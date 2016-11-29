//
//  RoutingMessage.test.swift
//  PeterParker
//
//  Created by Yevhen Dubinin on 11/29/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import XCTest

@testable import PeterParker

class RoutingMessage_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_routingTable() {
        let table: [RoutingMessage] = RoutingMessage.routingTable()
        XCTAssertNotEqual(table.count, 0)
    }
}
