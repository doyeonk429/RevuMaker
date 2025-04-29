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
                    .environmentObject(coordinator) // ✅ 반드시 주입
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .scanImage(let image):
                            ScanImageView(image: image)
                                .environmentObject(coordinator) // ✅ 여기서도 주입
                        case .confirmData(let storeData, let mode):
                            ConfirmDataView(storeData: storeData, mode: mode)
                                .environmentObject(coordinator) // ✅
                        case .selectRevu(let options):
                            SelectRevuView(options: options)
                                .environmentObject(coordinator) // ✅
                        case .selectConcept:
                            SelectConceptView()
                                .environmentObject(coordinator) // ✅
                        case .makeRevu(let option):
                            MakeRevuView()
                                .environmentObject(coordinator) // ✅
                        }
                    }
            }
        }
    }
}
