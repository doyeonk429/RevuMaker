//
//  ConfirmDataView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct ConfirmDataView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    let storeData: StoreModel
    let mode: ConfirmMode
    
    @State private var storeName: String = ""
    @State private var category: String = ""
    @State private var date: String = ""
    @State private var productNames: [Product] = []
    
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
                    TextFieldView(title: "방문 날짜", content: $date)
                    
                    ForEach(productNames.indices, id: \.self) { index in
                        VStack(spacing: 36) {
                            TextFieldView(title: "\(index+1). 품명", content: $productNames[index].name)
                            TextFieldView(title: "\(index+1). 수량", content: Binding(get: {
                                String(productNames[index].count)
                            }, set: { newValue in
                                productNames[index].count = Int(newValue) ?? 0
                                updateTotalPrice(at: index)
                            }))
                            TextFieldView(title: "\(index+1). 가격", content: Binding(get: {
                                String(productNames[index].price)
                            }, set: { newValue in
                                productNames[index].price = Int(newValue) ?? 0
                                updateTotalPrice(at: index)
                            }))
                        }
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
                    coordinator.pop()
                })
            }
        }
        .onAppear {
            storeName = storeData.storeName
            category = storeData.category
            date = storeData.date
            productNames = storeData.productNames
        }
    }
    
    private func updateTotalPrice(at index: Int) {
        let product = productNames[index]
        productNames[index].totalPrice = product.count * product.price
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
            return { coordinator.resetToRoot() }
        case .fromEmpty:
            return {
                productNames.append(Product(name: "", price: 0, count: 0, totalPrice: 0))
            }
        }
    }
    
    private var rightButtonAction: () -> Void {
        {
            let totalPrice = productNames.reduce(0) { $0 + $1.totalPrice }
            let updatedStoreData = StoreModel(
                storeName: storeName,
                date: date,
                category: category,
                storeTotalPrice: totalPrice,
                productNames: productNames
            )
            coordinator.push(Route.selectRevu)
        }
    }
}
