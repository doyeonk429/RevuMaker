//
//  MultiSelectFlowView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct SelectRevuView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    let options: [String]
    @State private var selectedItems: Set<String> = []
    
    private let buttonTitle : String = "다음"
    private var buttonAction: () -> Void {
        {
            coordinator.push(Route.selectConcept)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("어떤 경험이었나요?")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 24)
            Text("중복 선택 가능")
                .font(.system(size: 14, weight: .regular))
                .padding(.leading, 24)
                .foregroundStyle(.gray)
            
            VStack(alignment: .center) {
                List {
                    ForEach(options, id: \.self) { item in
                        Button(action: {
                            toggleSelection(for: item)
                        }) {
                            HStack {
                                Text(item)
                                    .foregroundColor(selectedItems.contains(item) ? .white : .black)
                                Spacer()
                                if selectedItems.contains(item) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(selectedItems.contains(item) ? Color.orange : Color.gray.opacity(0.2))
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden, edges: .all)
                    }
                }
                .listStyle(.plain)
                
                Button(buttonTitle) {
                    buttonAction()
                }
                .buttonStyle(OrangeRoundedButtonStyle(width: UIScreen.main.bounds.width - 24, height: 50))
                .padding(.all, 24)
            }
        }
        .padding(.top, 40)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(action: {
                    coordinator.pop()
                })
            }
        }
    }

    private func toggleSelection(for item: String) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
}
//
//#Preview {
//    SelectRevuView(options: [
//        "햄버거", "피자", "초콜릿", "콜라", "아메리카노", "수박주스", "맥주", "치킨", "삼겹살", "김치찌개"
//    ])
//}
