//
//  SocketAddress.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


public struct SocketAddress {
    public var _addresses: [sockaddr]
    public var _address: sockaddr { return self._addresses[0] }

    public init(_ _addresses: [sockaddr]) {
        self._addresses = _addresses
    }

    public init(_ _address: sockaddr) {
        self.init([_address])
    }

    public var family: SocketAddressFamily {
        return SocketAddressFamily(self._address.sa_family)
    }

    public var specifiedAddress: SpecifiedSocketAddress {
        switch self.family {
        case .IPv4:
            return IPv4SocketAddress(self)
        case .Link:
            return LinkSocketAddress(self)
        case .IPv6:
            return IPv6SocketAddress(self)
        default:
            return UnspecifiedSocketAddress(self)
        }
    }

    public var stringRepresentation: String? {
        return self.specifiedAddress.stringRepresentation
    }
}


extension SocketAddress {
}


extension SocketAddress: CustomStringConvertible {
    public var description: String {
        return
            "SocketAddress(" +
                "address: \(self.specifiedAddress.stringRepresentation)" +
            ")"
    }
}
