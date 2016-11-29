//
//  RouteType.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import PeterParkerPrivate.ifaddrs

/// Mapping of messages operating on routing table
///
/// See [route(4)](https://www.freebsd.org/cgi/man.cgi?query=route&sektion=4&apropos=0&manpath=FreeBSD+10.3-RELEASE+and+Ports)
public enum RouteType: CUnsignedChar {
    case add = 1
    case delete
    case change
    case get
    case losing
    case redirect
    case miss
    case lock
    case oldAdd
    case oldDel
    case resolve
    case newAddress
    case deleteAddress
    case interfaceInfo
    case newMembershipAddress
    case deleteMembershipAddress
    case getSilent
    case interfaceInfo2
    case newMembershipAddress2
    case get2
}


extension RouteType {
    public init(_ _routeType: CUnsignedChar) {
        self = RouteType(rawValue: _routeType)!
    }
}
