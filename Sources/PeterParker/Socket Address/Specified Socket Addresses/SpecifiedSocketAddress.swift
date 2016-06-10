//
//  SpecifiedSocketAddress.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation


public protocol SpecifiedSocketAddress {
    init(_: [sockaddr])
    init(_: SocketAddress)
    var stringRepresentation: String? { get }
}


extension SpecifiedSocketAddress {
    public init(_ socketAddress: SocketAddress) {
        self.init(socketAddress._addresses)
    }
}
