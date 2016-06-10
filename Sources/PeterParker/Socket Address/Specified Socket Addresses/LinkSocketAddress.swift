//
//  LinkSocketAddress.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


public struct LinkSocketAddress: SpecifiedSocketAddress {

    public var _address: sockaddr_dl

    public init(_ _addresses: [sockaddr]) {
        let _addressesBuffer = UnsafeBufferPointer<sockaddr>(start: _addresses, count: _addresses.count)
        let _addressBuffer = unsafeBitCast(_addressesBuffer, UnsafeBufferPointer<sockaddr_dl>.self)
        self._address = _addressBuffer.baseAddress.memory
    }

    public var stringRepresentation: String? {
        if self._address.sdl_nlen + self._address.sdl_alen + self._address.sdl_slen == 0 {
            return "link#\(self._address.sdl_index)"
        }

        var _address = self._address
        let cString: UnsafeMutablePointer<CChar> = link_ntoa(&_address)
        return String.fromCString(cString)
    }

}
