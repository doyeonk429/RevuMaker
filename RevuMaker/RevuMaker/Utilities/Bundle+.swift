//
//  Bundle+.swift
//  RevuMaker
//
//  Created by 김도연 on 4/30/25.
//

import Foundation

extension Bundle {
    var openAIKey: String? {
        guard let url = self.url(forResource: "Keys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            print("❌ Keys.plist not found or invalid")
            return nil
        }
        return dict["OPENAI_API_KEY"] as? String
    }
    
    var alanAPIKey: String? {
        guard let url = self.url(forResource: "Keys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            print("❌ Keys.plist not found or invalid")
            return nil
        }
        return dict["ALAN_API_KEY"] as? String
    }
    
    var alanBaseURL: String? {
        guard let url = self.url(forResource: "Keys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            print("❌ Keys.plist not found or invalid")
            return nil
        }
        return dict["BASE_URL"] as? String
    }
}
