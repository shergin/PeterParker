//
//  RoutingMessage.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import PeterParkerPrivate.ifaddrs
import PeterParkerPrivate.net_route


public struct RoutingMessage {
    // # Principal Fields
    public var _header: rt_msghdr2
    public var _addresses: [sockaddr]

    // # Deferred Fields
    public var addresses: [SocketAddress] {
        var addresses: [SocketAddress] = []

        var i = 0
        while i < self._addresses.count {
            if let address = self[i] {
                addresses.append(address)
            }
            i += 1
        }

        return addresses
    }

    public var destinationAddress: SocketAddress? {
        return self[Int(RTAX_DST)]
    }

    public var netmaskAddress: SocketAddress? {
        return self[Int(RTAX_NETMASK)]
    }

    public var gatewayAddress: SocketAddress? {
        return self[Int(RTAX_GATEWAY)]
    }

    public subscript(index: Int) -> SocketAddress? {
        guard index < self._addresses.count else { return nil }
        guard self.isValidSocketAddressAtIndex(index: index) else { return nil }

        var _addresses: [sockaddr] = [self._addresses[index]]

        var i = index + 1
        while !self.isValidSocketAddressAtIndex(index: i) && i < self._addresses.count {
            _addresses.append(self._addresses[i])
            i += 1
        }

        return SocketAddress(_addresses)
    }

    private func isValidSocketAddressAtIndex(index: Int) -> Bool {
        return self._header.rtm_addrs & (1 << Int32(index)) > 0
    }

    public var networkInterfaceName: String? {
        return NetworkInterface.interfaceNameByIndex(index: Int(self._header.rtm_index))
    }

    // # Flags
    public var routeType: RouteType {
        return RouteType(self._header.rtm_type)
    }

    public var referenceCount: Int {
        return Int(self._header.rtm_refcnt)
    }

    public var use: Int {
        return Int(self._header.rtm_use)
    }
}


extension RoutingMessage {
    public var stringRepresentation: String {
        let destination = self.destinationAddress!.stringRepresentation ?? "<destination>"
        let gateway = self.gatewayAddress!.stringRepresentation ?? "<gateway>"
        let referenceCount = String(self.referenceCount)
        let use = String(self.use)
        let interfaceName = self.networkInterfaceName ?? "unknown"
        return "\(destination) \(gateway) \(referenceCount) \(use) \(interfaceName)"
    }
}


extension RoutingMessage: CustomStringConvertible {
    public var description: String {
        return
            "RoutingMessage(" +
                "routeType: \(String(describing: self.routeType)), " +
                "destinationAddress: \(String(describing: self.destinationAddress?.description)), " +
                "netmaskAddress: \(String(describing: self.netmaskAddress?.description)), " +
                "gatewayAddress: \(String(describing: self.gatewayAddress?.description)), " +
                "routingAddresses: \(self.addresses), " +
            ")"
    }
}
