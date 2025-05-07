//
//  ReviewFlowViewModel.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import SwiftUI

final class ReviewFlowViewModel: ObservableObject {
    @Published var storeModel: StoreModel?
    @Published var selectedPrompts: [PromptData] = []
    @Published var selectedTone: ReviewTone = .friendly
    @Published var generatedReview: String?
}
