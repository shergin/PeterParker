//
//  RouteType.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


public enum RouteType: CUnsignedChar {
    case Add = 1
    case Delete
    case Change
    case Get
    case Losing
    case Redirect
    case Miss
    case Lock
    case OldAdd
    case OldDel
    case Resolve
    case NewAddress
    case DeleteAddress
    case InterfaceInfo
    case NewMembershipAddress
    case DeleteMembershipAddress
    case GetSilent
    case InterfaceInfo2
    case NewMembershipAddress2
    case Get2
}


extension RouteType {
    public init(_ _routeType: CUnsignedChar) {
        self = RouteType(rawValue: _routeType)!
    }
}
