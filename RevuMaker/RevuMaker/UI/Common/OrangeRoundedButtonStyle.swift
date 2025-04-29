//
//  OrangeRoundedButtonStyle.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct OrangeRoundedButtonStyle: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var backgroundColor = Color.orange
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(.black)
            .padding(.horizontal, 24) // ✨ 텍스트 좌우 여백만 추가
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
