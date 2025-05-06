//
//  ReviewWebRepository.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import Foundation

protocol ReviewWebRepository: WebRepository {
    func generateReview(store: StoreModel, tone: ReviewTone, prompts: [PromptData]) async throws -> String
}

final class AlanRepository: ReviewWebRepository {

    let session: URLSession
    let baseURL: String
    private let clientID: String

    init(session: URLSession) {
        guard let alanURL = Bundle.main.alanBaseURL else {
            fatalError("[Bundle Error] BaseURL is missing")
        }
        
        guard let alanKey = Bundle.main.alanAPIKey else {
            fatalError("[Bundle Error] ALAN API key is missing")
        }
        
        self.session = session
        self.baseURL = alanURL
        self.clientID = alanKey
    }
    
    func generateReview(store: StoreModel, tone: ReviewTone, prompts: [PromptData]) async throws -> String {
        let prompt = makeReviewPrompt(store: store, tone: tone, prompts: prompts)
        let request = AlanRequestModel(content: prompt, client_id: clientID)
        return try await generateReview(request: request)
    }
    
    private func generateReview(request: AlanRequestModel) async throws -> String {
        let endpoint = API.generateReview(request: request)
        let response: String = try await call(endpoint: endpoint)
        return response
    }
    
    private func makeReviewPrompt(
        store: StoreModel,
        tone: ReviewTone,
        prompts: [PromptData]
    ) -> String {
        let toneDescription = tone.rawValue
        let toneExample = tone.example
        let positivePoints = prompts.map { "- \($0.desc)" }.joined(separator: "\n")

        let productsText = store.productNames.map {
            "- \($0.name) (\($0.count)개, 개당 \($0.price)원, 총 \($0.totalPrice)원)"
        }.joined(separator: "\n")

        return """
        아래는 사용자의 방문 정보입니다. 이 내용을 참고해 \(toneDescription)로 리뷰를 작성해주세요. 결과는 단일 문단의 리뷰 텍스트로 제공해주세요.

        가게 이름: \(store.storeName)
        방문 날짜: \(store.date)
        업종: \(store.category)
        총 결제 금액: \(store.storeTotalPrice)원
        주문한 상품:
        \(productsText)

        긍정적 포인트:
        \(positivePoints)

        작성할 말투 스타일: "\(toneDescription)"
        해당 말투 예시:
        \(toneExample)
        """
    }
}
