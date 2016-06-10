//
//  SocketAddressFamily.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation


public enum SocketAddressFamily: sa_family_t {
    case Unspecified = 0         // AF_UNSPEC
    case Unix = 1                // AF_UNIX
    case IPv4 = 2                // AF_INET
    case ImpLink = 3             // AF_IMPLINK
    case Pup = 4                 // AF_PUP
    case CHAOS = 5               // AF_CHAOS
    case NS = 6                  // AF_NS
    case ISO = 7                 // AF_ISO
    case ECMA = 8                // AF_ECMA
    case DataKit = 9             // AF_DATAKIT
    case CCITT = 10              // AF_CCITT
    case SNA = 11                // AF_SNA
    case DECnet = 12             // AF_DECnet
    case DLI = 13                // AF_DLI
    case LAT = 14                // AF_LAT
    case HYLINK = 15             // AF_HYLINK
    case AppleTalk = 16          // AF_APPLETALK
    case Routing = 17            // AF_ROUTE
    case Link = 18               // AF_LINK
    case PseudoXTP = 19          // pseudo_AF_XTP
    case COIP = 20               // AF_COIP
    case CNT = 21                // AF_CNT
    case PseudoRTIP = 22         // pseudo_AF_RTIP
    case IPX = 23                // AF_IPX
    case SIP = 24                // AF_SIP
    case PIP = 25                // pseudo_AF_PIP
    case Blue = 26               // pseudo_AF_BLUE
    case NDRV = 27               // AF_NDRV
    case ISDN = 28               // AF_ISDN
    case PseudoKey = 29          // pseudo_AF_KEY
    case IPv6 = 30               // AF_INET6
    case NATM = 31               // AF_NATM
    case System = 32             // AF_SYSTEM
    case NetBIOS = 33            // AF_NETBIOS
    case PPP = 34                // AF_PPP
    case PseudoHDRCMPLT = 35     // pseudo_AF_HDRCMPLT
    case Reserved36 = 36         // AF_RESERVED_36
    case IEEE80211 = 37          // AF_IEEE80211
    case UTUN = 38               // AF_UTUN
}


extension SocketAddressFamily {
    public init(_ sa_family: sa_family_t) {
        self = SocketAddressFamily(rawValue: sa_family) ?? .Unspecified
    }
}
