//
//  AlanRepository+API.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import Foundation

extension AlanRepository {
    enum API {
        case generateReview(request: AlanRequestModel)
    }
}

extension AlanRepository.API: APICall {
    var path: String {
        switch self {
        case .generateReview:
            return "/api/v1/question"
        }
    }

    var method: String {
        return "POST"
    }

    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        switch self {
        case .generateReview(let request):
            return try? JSONEncoder().encode(request)
        }
    }
}
