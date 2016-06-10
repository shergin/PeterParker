//
//  String+Padding.swift
//  PeterParker
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 The PeterParker Authors. All rights reserved.
//


extension String {
    internal func padLeft(length: Int, character: Character = " ") -> String {
        var compoundString = String(count: length, repeatedValue: character) + self
        return compoundString.substringFromIndex(compoundString.endIndex.advancedBy(-length))
    }

    internal func padRight(length: Int, character: Character = " ") -> String {
        var compoundString = self + String(count: length, repeatedValue: character)
        return compoundString.substringToIndex(compoundString.startIndex.advancedBy(length))
    }
}
