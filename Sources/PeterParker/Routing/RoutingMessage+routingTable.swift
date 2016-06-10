//
//  RoutingMessage+routingTable.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


extension RoutingMessage {
    private init(_ routingMessage: UnsafeMutablePointer<rt_msghdr2>) {
        let buffer = UnsafeMutablePointer<Int8>(routingMessage)
        let routingMessageSize = Int(routingMessage.memory.rtm_msglen)
        let firstRoutingAddress = UnsafeMutablePointer<sockaddr>(buffer.advancedBy(sizeof(rt_msghdr2)))
        let routingAddressesCount = (routingMessageSize - sizeof(rt_msghdr2)) / sizeof(sockaddr)
        let routingAddresses = UnsafeMutableBufferPointer<sockaddr>(start: firstRoutingAddress, count: routingAddressesCount)
        self.init(routingMessage, routingAddresses)
    }

    private init(_ _header: UnsafeMutablePointer<rt_msghdr2>, _ _addresses: UnsafeMutableBufferPointer<sockaddr>) {
        self.init(_header.memory, Array(_addresses.generate()))
    }

    private init(_ _header: rt_msghdr2, _ _addresses: [sockaddr]) {
        self._header = _header
        self._addresses = _addresses
    }

    static func routingTable() -> [RoutingMessage] {
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
            print(routingMessage.memory.rtm_msglen)
            routes.append(RoutingMessage(routingMessage))

            let routingMessageSize = Int(routingMessage.memory.rtm_msglen)
            routingMessageBuffer = routingMessageBuffer.advancedBy(routingMessageSize)
        }

        return routes
    }
}