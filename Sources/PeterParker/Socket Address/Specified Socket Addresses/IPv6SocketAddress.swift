//
//  IPv6SocketAddress.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


public struct IPv6SocketAddress: SpecifiedSocketAddress {

    public var _address: sockaddr_in6

    public init(_ _addresses: [sockaddr]) {
        let _addressesBuffer = UnsafeBufferPointer<sockaddr>(start: _addresses, count: _addresses.count)
        let _addressBuffer = unsafeBitCast(_addressesBuffer, UnsafeBufferPointer<sockaddr_in6>.self)
        self._address = _addressBuffer.baseAddress.memory
    }

    public var stringRepresentation: String? {
        var buffer = [CChar](count: Int(INET6_ADDRSTRLEN), repeatedValue: CChar(0))
        var _address = self._address
        let cString: UnsafePointer<CChar> = inet_ntop(AF_INET6, &_address.sin6_addr, &buffer, socklen_t(INET6_ADDRSTRLEN))
        return String.fromCString(cString)
    }
}
