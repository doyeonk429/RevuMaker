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

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                HomeView()
                    .environmentObject(coordinator)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .scanImage(let image):
                            ScanImageView(image: image)
                                .environmentObject(coordinator)
                        case .confirmData(let storeData, let mode):
                            ConfirmDataView(storeData: storeData, mode: mode)
                                .environmentObject(coordinator)
                        case .selectRevu:
                            SelectRevuView()
                                .environmentObject(coordinator)
                        case .selectConcept:
                            SelectConceptView()
                                .environmentObject(coordinator)
                        case .makeRevu(_):
                            MakeRevuView()
                                .environmentObject(coordinator)
                        }
                    }
            }
        }
    }
}
