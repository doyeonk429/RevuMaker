//
//  Test.swift
//  RevuMaker
//
//  Created by 김도연 on 4/28/25.
//

import SwiftUI

final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func resetToRoot() {
        path.removeLast(path.count)
    }

    func push<V: Hashable>(_ value: V) {
        path.append(value)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}

enum Route: Hashable {
    case scanImage(UIImage)
    case confirmData(StoreModel, ConfirmMode)
    case selectRevu
    case selectConcept
    case makeRevu(ReviewTone)
}

final class AppStateStore: ObservableObject {
    @Published var recentGeneratedReviews: [String] = []
    // 필요 시 사용자 설정, 진행 상태 등 추가 가능
}
