//
//  ConfirmDataView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct ConfirmDataView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToSelectRevu = false
    let storeData: StoreModel
    let mode: ConfirmMode
    
    @State private var storeName: String = ""
    @State private var category: String = ""
    @State private var productNames: [String] = []
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.all, 24)
                .padding(.top, 40)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 36) {
                    TextFieldView(title: "가게명", content: $storeName)
                    TextFieldView(title: "업종", content: $category)
                    
                    ForEach(productNames.indices, id: \.self) { index in
                        TextFieldView(title: "품명", content: $productNames[index])
                    }
                }
                .padding(.top, 24)
            }
            .frame(height: UIScreen.main.bounds.height * 0.65)
            
            HStack(spacing: 16) {
                HomeActionButton(title: leftButtonTitle, action: leftButtonAction)
                HomeActionButton(title: rightButtonTitle, action: rightButtonAction)
            }
            .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(action: {
                    dismiss()
                })
            }
        }
        .onAppear {
            print("데이터 가져옴")
            storeName = storeData.storeName
            category = storeData.category
            productNames = storeData.productNames
        }
        .navigationDestination(isPresented: $navigateToSelectRevu) {
            SelectRevuView(options: [
                "햄버거", "피자", "초콜릿", "콜라", "아메리카노", "수박주스", "맥주", "치킨", "삼겹살", "김치찌개"
            ])
        }
    }
    
    private var titleText: String {
        switch mode {
        case .fromScan:
            return "\(storeName)에 다녀오셨어요!"
        case .fromEmpty:
            return "어떤 곳을 다녀오셨나요?"
        }
    }
    
    private var leftButtonTitle: String {
        switch mode {
        case .fromScan:
            return "다시 스캔하기"
        case .fromEmpty:
            return "상품 추가하기"
        }
    }
    
    private var rightButtonTitle: String {
        switch mode {
        case .fromScan:
            return "정보가 맞아요"
        case .fromEmpty:
            return "다 입력했어요"
        }
    }
    
    private var leftButtonAction: () -> Void {
        switch mode {
        case .fromScan:
            return { dismiss() }
        case .fromEmpty:
            return {
                productNames.append("")
            }
        }
    }
    
    private var rightButtonAction: () -> Void {
        {
            navigateToSelectRevu = true
        }
    }
}
