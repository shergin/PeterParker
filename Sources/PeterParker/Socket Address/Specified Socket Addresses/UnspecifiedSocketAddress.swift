//
//  UnspecifiedSocketAddress.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//

import Foundation
import ifaddrs


public struct UnspecifiedSocketAddress: SpecifiedSocketAddress {

    public var _addresses: [sockaddr]

    public init(_ _addresses: [sockaddr]) {
        self._addresses = _addresses
    }

    public var stringRepresentation: String? {
        /*
        let totalLength = self._addresses[0].sa_len
        let _addressesBuffer = UnsafeBufferPointer<sockaddr>(start: _addresses, count: _addresses.count)
        let _data = UnsafePointer(_addresses[0].sa_data)
        let dataLength = totalLength - (_data.distanceTo(_addressBuffer))
        let _dataBuffer = UnsafeBufferPointer<Int8>(start: _addresses[0].sa_data, count: dataLength)

        let bytes = Array(_dataBuffer.enumerate())
        bytes.map {  }

        self._address = _addressBuffer.baseAddress.memory
        */
        return "Unspecified"
    }
    
}

