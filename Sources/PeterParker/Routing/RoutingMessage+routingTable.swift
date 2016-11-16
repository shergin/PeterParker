//
//  RoutingMessage+routingTable.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import PeterParkerPrivate.ifaddrs
import PeterParkerPrivate.net_route


extension RoutingMessage {
    public init(_ routingMessage: UnsafeMutablePointer<rt_msghdr2>) {
        let buffer = UnsafeMutablePointer<Int8>(routingMessage)
        let routingMessageSize = Int(routingMessage.memory.rtm_msglen)
        let firstRoutingAddress = UnsafeMutablePointer<sockaddr>(buffer.advancedBy(sizeof(rt_msghdr2)))
        let routingAddressesCount = (routingMessageSize - sizeof(rt_msghdr2)) / sizeof(sockaddr)
        let routingAddresses = UnsafeMutableBufferPointer<sockaddr>(start: firstRoutingAddress, count: routingAddressesCount)
        self.init(routingMessage, routingAddresses)
    }

    public init(_ _header: UnsafeMutablePointer<rt_msghdr2>, _ _addresses: UnsafeMutableBufferPointer<sockaddr>) {
        self.init(_header.memory, Array(_addresses.generate()))
    }

    public init(_ _header: rt_msghdr2, _ _addresses: [sockaddr]) {
        self._header = _header
        self._addresses = _addresses
    }
}


extension RoutingMessage {
    public static func routingTable() -> [RoutingMessage] {
        var name = [Int32]([
            CTL_NET,
            PF_ROUTE,
            0,
            0,
            NET_RT_DUMP2,
            0
        ])

        let nameSize = u_int(name.count)

        var bufferSize: size_t = 0

        if sysctl(&name, nameSize, nil, &bufferSize, nil, 0) < 0 {
            return []
        }

        let buffer = UnsafeMutablePointer<Int8>.alloc(bufferSize)
        let bufferLimit = buffer.advancedBy(bufferSize)
        defer {
            buffer.dealloc(bufferSize)
        }

        if sysctl(&name, nameSize, buffer, &bufferSize, nil, 0) < 0 {
            return []
        }

        var routes: [RoutingMessage] = []

        var routingMessageBuffer = buffer
        while routingMessageBuffer < bufferLimit {
            let routingMessage = UnsafeMutablePointer<rt_msghdr2>(routingMessageBuffer)
            routes.append(RoutingMessage(routingMessage))

            let routingMessageSize = Int(routingMessage.memory.rtm_msglen)
            routingMessageBuffer = routingMessageBuffer.advancedBy(routingMessageSize)
        }

        return routes
    }
}
