//
//  RevuMakerApp.swift
//  RevuMaker
//
//  Created by 김도연 on 4/28/25.
//

import SwiftUI

@main
struct RevuMakerApp: App {
    @StateObject private var coordinator = NavigationCoordinator()
    
    let container: DIContainer

    init() {
        let coordinator = NavigationCoordinator()
        self._coordinator = StateObject(wrappedValue: coordinator)
        self.container = DIContainer(
            appState: AppStateStore(),
            repositories: .init(
                reviewWebRepository: AlanRepository(session: .shared)
            ),
            coordinator: coordinator
        )
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                HomeView()
                    .inject(container)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .scanImage(let image):
                            ScanImageView(image: image).inject(container)
                        case .confirmData(let storeData, let mode):
                            ConfirmDataView(storeData: storeData, mode: mode)
                                .inject(container)
                        case .selectRevu:
                            SelectRevuView()
                                .inject(container)
                        case .selectConcept:
                            SelectConceptView()
                                .inject(container)
                        case .makeRevu(_):
                            MakeRevuView()
                                .inject(container)
                        }
                    }
            }
        }
    }
}
