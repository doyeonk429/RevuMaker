//
//  APICall.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum APIError: Swift.Error, Equatable {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "잘못된 URL"
        case let .httpCode(code): return "HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}
