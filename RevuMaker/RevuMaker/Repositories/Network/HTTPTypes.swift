//
//  HTTPTypes.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import Foundation

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
