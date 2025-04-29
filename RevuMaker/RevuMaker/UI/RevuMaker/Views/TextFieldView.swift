//
//  TextFieldView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct TextFieldView: View {
    let title: String
    @State var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.orange)
                .padding(.horizontal, 24)

            TextField("", text: $content)
                .font(.system(size: 16, weight: .regular))
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
                .background(Color.clear)
                .overlay(
                    Rectangle()
                        .frame(height: 1.5)
                        .foregroundColor(content.isEmpty ? .gray : .orange)
                        .padding(.horizontal, 24),
                    alignment: .bottom
                )
        }
    }
}

#Preview {
//    TextFieldView(title: "가게명", content: "초코찰떡파이")
    TextFieldView(title: "가게명", content: "")
}
