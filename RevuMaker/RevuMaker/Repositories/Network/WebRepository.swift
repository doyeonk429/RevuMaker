//
//  WebRepository.swift
//  RevuMaker
//
//  Created by 김도연 on 5/6/25.
//

import Foundation
import Combine

enum ApiModel { }

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var defaultHeaders: [String: String] { get }
}

extension WebRepository {
    var defaultHeaders: [String: String] {
        ["Content-Type": "application/json"]
    }

    func call<Value: Decodable, Decoder: TopLevelDecoder>(
        endpoint: APICall,
        decoder: Decoder = JSONDecoder(),
        httpCodes: HTTPCodes = .success
    ) async throws -> Value where Decoder.Input == Data {

        let request = try makeURLRequest(endpoint: endpoint)
        let (data, response) = try await session.data(for: request)

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        guard httpCodes.contains(code) else {
            throw APIError.httpCode(code)
        }

        do {
            return try decoder.decode(Value.self, from: data)
        } catch {
            debugPrint("Decoding error: \(error)")
            debugPrint(String(data: data, encoding: .utf8) ?? "No response string")
            throw APIError.unexpectedResponse
        }
    }

    private func makeURLRequest(endpoint: APICall) throws -> URLRequest {
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = defaultHeaders.merging(endpoint.headers ?? [:], uniquingKeysWith: { $1 })
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        return request
    }
}
