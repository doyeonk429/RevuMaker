//
//  MakeRevuView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct MakeRevuView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    @State private var isTextGenerated: Bool = false
    @State private var generatedRevuText: String = "여기에 생성된 리뷰 텍스트가 들어갑니다. SwiftUI로 간단하게 만들 수 있어요! 여기에 생성된 리뷰 텍스트가 들어갑니다. SwiftUI로 간단하게 만들 수 있어요!"

    var body: some View {
        VStack {
            TextStatusLabelView(isCompleted: isTextGenerated)
            
            if !isTextGenerated {
                Image(uiImage: UIImage(systemName: "globe")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                BottomActionAreaView(
                    descriptionText: generatedRevuText,
                    singleButtonAction: {
                        copyToClipboard(text: generatedRevuText)
                    },
                    firstHStackButtonAction: {
                        isTextGenerated.toggle()
                        coordinator.pop()
                    },
                    secondHStackButtonAction: {
                        coordinator.resetToRoot()
                    }
                )
            }
            
            Button(action: {
                isTextGenerated.toggle()
            }) {
                Text(isTextGenerated ? "다시 생성하기" : "완료 상태로 변경")
            }
            .buttonStyle(OrangeRoundedButtonStyle(width: 180, height: 40, backgroundColor: .green))
            .padding(8)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
    
}

struct TextStatusLabelView: View {
    let isCompleted: Bool

    var body: some View {
        Text(isCompleted ? "리뷰 생성이 완료되었어요!" : "리뷰를 만들고 있어요...")
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(isCompleted ? .orange : .black)
            .padding()
    }
}

struct BottomActionAreaView: View {
    let descriptionText: String
    let singleButtonTitle: String = "복사하기"
    let firstHStackButtonTitle: String = "다시 생성하기"
    let secondHStackButtonTitle: String = "홈으로 가기"

    let singleButtonAction: () -> Void
    let firstHStackButtonAction: () -> Void
    let secondHStackButtonAction: () -> Void

    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button(action: singleButtonAction) {
                    HStack(spacing: 4) {
                        Image(systemName: "document.on.document")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        Text(singleButtonTitle)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                            .underline()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 8)
            
            ScrollView {
                Text(descriptionText)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .padding(.all, 16)
            }
            .frame(width: UIScreen.main.bounds.width * 0.85, height: 400)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding(.bottom, 24)
            
            HStack(spacing: 16) {
                Button(action: firstHStackButtonAction) {
                    Text(firstHStackButtonTitle)
                }
                .buttonStyle(OrangeRoundedButtonStyle(width: (UIScreen.main.bounds.width * 0.8 - 16) / 2, height: 50))

                Button(action: secondHStackButtonAction) {
                    Text(secondHStackButtonTitle)
                }
                .buttonStyle(OrangeRoundedButtonStyle(width: (UIScreen.main.bounds.width * 0.8 - 16) / 2, height: 50))
            }
            
        }
        .padding(.all, 24)
    }
}
