//
//  NetworkInterface.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation


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

        var ifaddrsPtr: UnsafeMutablePointer<ifaddrs> = nil

        guard getifaddrs(&ifaddrsPtr) == 0 else {
            throw NSError(domain: "PeterParker", code: 1, userInfo: nil)
        }

        var ifaddrPtr = ifaddrsPtr
        while ifaddrPtr != nil {
            let addr = ifaddrPtr.memory.ifa_addr.memory

            if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                interfaces.append(NetworkInterface(ifaddr: ifaddrPtr.memory))
            }

            ifaddrPtr = ifaddrPtr.memory.ifa_next
        }

        freeifaddrs(ifaddrsPtr)

        return interfaces
    }

    init(ifaddr: ifaddrs) {
        let flags = Int32(ifaddr.ifa_flags)
        let isBroadcastValid = (flags & IFF_BROADCAST) == IFF_BROADCAST

        self.name = String.fromCString(ifaddr.ifa_name)!

        self.isRunning = (flags & IFF_RUNNING) == IFF_RUNNING
        self.isUp = (flags & IFF_UP) == IFF_UP ? true : false
        self.isLoopback = (flags & IFF_LOOPBACK) == IFF_LOOPBACK
        self.supportsMulticast = (flags & IFF_MULTICAST) == IFF_MULTICAST
        self.address = SocketAddress(ifaddr.ifa_addr.memory)
        self.netmask = SocketAddress(ifaddr.ifa_netmask.memory)
        self.broadcastAddress = (isBroadcastValid && ifaddr.ifa_dstaddr != nil) ? SocketAddress(ifaddr.ifa_dstaddr.memory) : nil
    }
}


extension NetworkInterface {
    static func interfaceNameByIndex(index: Int) -> String? {
        var buffer = [CChar](count: Int(IFNAMSIZ) + 1, repeatedValue: CChar(0))
        let result = if_indextoname(UInt32(index), &buffer)
        return String.fromCString(result)
    }
}


extension String {
    func padLeft(length: Int, character: Character = " ") {
        var compoundString = String(count: length, repeatedValue: character) + self
        return compoundString.substringFrom(compoundString.endIndex.advancedBy(-length))
    }

    func padRight(length: Int, character: Character = " ") {
        var compoundString = self + String(count: length, repeatedValue: character)
        return compoundString.substringTo(compoundString.beginIndex.advancedBy(length))
    }
}