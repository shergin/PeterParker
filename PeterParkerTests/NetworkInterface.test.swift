//
//  NetworkInterface.test.swift
//  PeterParker
//
//  Created by Yevhen Dubinin on 11/28/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import XCTest

@testable import PeterParker

class NetworkInterface_test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_allInterfaces_returnsSomething() {
        do {
            let allInterfaces: [NetworkInterface] = try NetworkInterface.allInterfaces()
            XCTAssertNotEqual(allInterfaces.count, 0, "NetworkInterface.allInterfaces() is expected to return some data")
        }
        catch let error {
            XCTFail("NetworkInterface.allInterfaces() thrown error: \(error)")
        }
    }
    
    func test_allInterfaces_print() {
        do {
            let allInterfaces: [NetworkInterface] = try NetworkInterface.allInterfaces()
            print("NetworkInterfaces:")
            for networkInterface in allInterfaces {
                print(networkInterface)
            }
        }
        catch let error {
            XCTFail("NetworkInterface.allInterfaces() thrown error: \(error)")
        }
    }
}
