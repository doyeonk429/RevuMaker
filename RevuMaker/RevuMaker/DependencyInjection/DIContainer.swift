//
//  DIContainer.swift
//  RevuMaker
//
//  Created by 김도연 on 5/7/25.
//

import SwiftUI

struct DIContainer {
    let appState: AppStateStore
    let repositories: Repositories
    let coordinator: NavigationCoordinator
}

extension DIContainer {
    struct Repositories {
        let reviewWebRepository: ReviewWebRepository
        // 추후 reviewDBRepository도 여기에 추가
    }
}

private struct DIContainerKey: EnvironmentKey {
    static let defaultValue: DIContainer = .init(coordinator: .init())
}

extension EnvironmentValues {
    var di: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}

extension View {
    func inject(_ container: DIContainer) -> some View {
        self.environment(\.di, container)
    }
}

