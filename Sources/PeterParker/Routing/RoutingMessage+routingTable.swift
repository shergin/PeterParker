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

fileprivate enum RoutingMessageError: Swift.Error {
    case zeroRoutingMessageSize
}

extension RoutingMessage {
    public init(_ routingMessage: UnsafeMutablePointer<rt_msghdr2>) throws {
        
        /// WARNING: unsafeBitCast(_:to:) is very dangerous!
        /// Read more here: https://swift.org/migration-guide/se-0107-migrate.html
        /// TODO: reinterpret the in-memory values as the rt_msghdr2 type in a SAFE WAY
        
        let buffer = unsafeBitCast(routingMessage.self, to: UnsafeMutablePointer<UInt8>.self)
        let routingMessageSize: CUnsignedShort = routingMessage.pointee.rtm_msglen
        guard routingMessageSize > 0 else {
            throw RoutingMessageError.zeroRoutingMessageSize
        }
        let firstRoutingAddressPtr = buffer.advanced(by: MemoryLayout<rt_msghdr2>.stride)
        let firstRoutingAddress = unsafeBitCast(firstRoutingAddressPtr.self, to: UnsafeMutablePointer<sockaddr>.self)
        let routingAddressesCount = (Int(routingMessageSize) - MemoryLayout<rt_msghdr2>.size) / MemoryLayout<sockaddr>.size
        let routingAddresses = UnsafeMutableBufferPointer<sockaddr>(start: firstRoutingAddress, count: routingAddressesCount)
        self.init(routingMessage, routingAddresses)
    }

    public init(_ _header: UnsafeMutablePointer<rt_msghdr2>, _ _addresses: UnsafeMutableBufferPointer<sockaddr>) {
        self.init(_header.pointee, Array(_addresses.makeIterator()))
    }

    public init(_ _header: rt_msghdr2, _ _addresses: [sockaddr]) {
        self._header = _header
        self._addresses = _addresses
    }
}


extension RoutingMessage {
    // TODO: make the method throw
    public static func routingTable() -> [RoutingMessage] {
        /// Get system information
        ///
        /// See [sysctl(3)](https://www.freebsd.org/cgi/man.cgi?sysctl(3)).
        ///
        /// Requesting the information of the following levels:
        var name = [Int32]([
            CTL_NET,        // Networking
            PF_ROUTE,       // routing messages
            0,              // protocol number (always 0)
            0,              // address family (all address families)
            NET_RT_DUMP2,   // dump?
            0               // None
        ])
        let nameSize = u_int(name.count)
        var bufferSize: size_t = 0
        if sysctl(&name, nameSize, nil, &bufferSize, nil, 0) < 0 {
            return [] // TODO: process return error code
        }

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)

        let bufferLimit = buffer.advanced(by:bufferSize)
        defer {
            buffer.deallocate(capacity: bufferSize)
        }

        if sysctl(&name, nameSize, buffer, &bufferSize, nil, 0) < 0 {
            return [] // TODO: process return error code
        }

        var routes: [RoutingMessage] = []

        var routingMessageBuffer = buffer
        while routingMessageBuffer < bufferLimit {
            
            /// WARNING: unsafeBitCast(_:to:) is very dangerous!
            /// Read more here: https://swift.org/migration-guide/se-0107-migrate.html
            /// TODO: reinterpret the in-memory values as the rt_msghdr2 type in a SAFE WAY
            
            let routingMessage = unsafeBitCast(routingMessageBuffer.self, to: UnsafeMutablePointer<rt_msghdr2>.self)
            
            do {
                let routingMessageValue = try RoutingMessage(routingMessage)
                routes.append(routingMessageValue)
            }
            catch let error {
                print("Failed to create RoutingMessage. Error was:\n\(error)")
            }
            
            let routingMessageSize = Int(routingMessage.pointee.rtm_msglen)
            routingMessageBuffer = routingMessageBuffer.advanced(by: routingMessageSize)
        }

        return routes
    }
}
