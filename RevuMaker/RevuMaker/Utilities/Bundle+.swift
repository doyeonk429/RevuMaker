//
//  Bundle+.swift
//  RevuMaker
//
//  Created by 김도연 on 4/30/25.
//

import Foundation

extension Bundle {
    var openAIKey: String? {
        return getValueFromKeysFile(for: "OPENAI_API_KEY")
    }

    var alanAPIKey: String? {
        return getValueFromKeysFile(for: "ALAN_API_KEY")
    }

    var alanBaseURL: String? {
        return getValueFromKeysFile(for: "BASE_URL")
    }

    private func getValueFromKeysFile(for key: String) -> String? {
        guard let url = self.url(forResource: "Keys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization
                              .propertyList(from: data, format: nil) as? [String: Any] else {
            print("❌ Keys.plist not found or invalid")
            return nil
        }
        return dict[key] as? String
    }
}
