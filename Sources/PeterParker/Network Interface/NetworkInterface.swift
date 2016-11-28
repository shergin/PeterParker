//
//  NetworkInterface.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import PeterParkerPrivate.ifaddrs

/// See [getifaddrs](https://www.freebsd.org/cgi/man.cgi?getifaddrs)
public struct NetworkInterface {
    public var name: String = ""
    public var address: SocketAddress? = nil
    public var netmask: SocketAddress? = nil
    public var broadcastAddress: SocketAddress? = nil
    public var isRunning: Bool = false
    public var isUp: Bool = false
    public var isLoopback: Bool = false
    public var supportsMulticast: Bool = false
}


extension NetworkInterface {
    public static func allInterfaces() throws -> [NetworkInterface] {
        var interfaces: [NetworkInterface] = []

        var ifaddrsPtr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddrsPtr) == 0 else {
            throw NSError(domain: "PeterParker", code: 1, userInfo: nil)
        }

        var ifaddrPtr = ifaddrsPtr
        while ifaddrPtr != nil {
            let addr = ifaddrPtr!.pointee.ifa_addr.pointee
            
            if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                interfaces.append(NetworkInterface(ifaddr: ifaddrPtr!.pointee))
            }
            
            ifaddrPtr = ifaddrPtr!.pointee.ifa_next
        }

        freeifaddrs(ifaddrsPtr)

        return interfaces
    }

    init(ifaddr: ifaddrs) {
        let flags = Int32(ifaddr.ifa_flags)
        let isBroadcastValid = (flags & IFF_BROADCAST) == IFF_BROADCAST
        
        self.name = String(cString: ifaddr.ifa_name)
        
        self.isRunning = (flags & IFF_RUNNING) == IFF_RUNNING
        self.isUp = (flags & IFF_UP) == IFF_UP ? true : false
        self.isLoopback = (flags & IFF_LOOPBACK) == IFF_LOOPBACK
        self.supportsMulticast = (flags & IFF_MULTICAST) == IFF_MULTICAST
        self.address = SocketAddress(ifaddr.ifa_addr.pointee)
        self.netmask = SocketAddress(ifaddr.ifa_netmask.pointee)
        self.broadcastAddress = (isBroadcastValid && ifaddr.ifa_dstaddr != nil) ? SocketAddress(ifaddr.ifa_dstaddr.pointee) : nil
    }
}

extension NetworkInterface {
    static func interfaceNameByIndex(index: Int) -> String? {
        var buffer = [CChar](repeating: CChar(0), count: Int(IFNAMSIZ) + 1)
        guard let result = if_indextoname(UInt32(index), &buffer) else {
            return nil
        }
        return String(cString: result)
    }
}
