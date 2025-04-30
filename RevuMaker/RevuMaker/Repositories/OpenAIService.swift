//
//  OpenAIService.swift
//  RevuMaker
//
//  Created by 김도연 on 4/30/25.
//

import UIKit
import OpenAI

final class OpenAIService {
    static let shared = OpenAIService()

    private let client: OpenAI

    private init() {
        guard let key = Bundle.main.openAIKey else {
            fatalError("❌ OpenAI API Key is missing")
        }
        client = OpenAI(configuration: .init(token: key))
    }
    
    /// Analyzes a receipt image using the OpenAI API and extracts structured receipt information in JSON format.
        ///
        /// Converts the provided image to a compressed JPEG, encodes it as a base64 data URL, and sends it to the GPT model with a prompt requesting only a specific JSON structure describing the receipt details (store name, date, category, total price, and product list).
        ///
        /// - Parameter image: The receipt image to analyze.
        /// - Returns: A JSON string containing the extracted receipt information, or "결과 없음" if no result is returned.
        /// - Throws: An error if the image cannot be encoded or if the OpenAI API request fails.
    func analyzeReceiptImage(_ image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            throw NSError(domain: "ImageEncoding", code: -1, userInfo: nil)
        }

        // base64로 인코딩된 이미지 문자열 생성
        let base64Image = imageData.base64EncodedString()
        let imageURL = "data:image/jpeg;base64,\(base64Image)"

        // GPT에게 JSON만 정확하게 요청
        let prompt = """
        다음 이미지는 영수증입니다. 아래 형식의 JSON만 정확하게 출력해주세요. 설명은 생략하고 JSON만 응답해 주세요.

        {
          "storeName": "스타벅스 강남점",
          "date": "2024-04-29",
          "category": "카페",
          "storeTotalPrice": 17400,
          "productNames": [
            {
              "name": "아메리카노",
              "price": 4500,
              "count": 2,
              "totalPrice": 9000
            },
            {
              "name": "크루아상",
              "price": 4200,
              "count": 2,
              "totalPrice": 8400
            }
          ]
        }
        """
        // Vision 모델로 요청
        let query = ChatQuery(
            messages: [.system(.init(content: prompt)), .user(.init(content: .vision([.chatCompletionContentPartImageParam(.init(imageUrl: .init(url: imageURL, detail: .auto)))])))],
            model: .gpt3_5Turbo,
            maxTokens: 1500,
            temperature: 0.2)

        let result = try await client.chats(query: query)
        return result.choices.first?.message.content ?? "결과 없음"
    }
}


