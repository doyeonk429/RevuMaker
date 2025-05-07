//
//  SelectConceptView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct SelectConceptView: View {
    @EnvironmentObject var reviewFlow: ReviewFlowViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    @State private var selectedItem: ReviewTone?
    @State private var currentItem: ReviewTone = .friendly
    @State private var showingInfoSheet = false
    
    private var buttonAction: () -> Void {
        {
            if let item = selectedItem {
                reviewFlow.selectedTone = item
                coordinator.push(Route.makeRevu(item))
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("어떤 말투로 작성할까요?")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 24)
            Text("선택지에 따라 말투가 달라져요.\n우측 버튼을 눌러 말투를 미리 확인해보세요!")
                .font(.system(size: 14, weight: .regular))
                .padding(.leading, 24)
                .padding(.bottom, 16)
                .foregroundStyle(.gray)
            
            VStack(alignment: .center) {
                List {
                    ForEach(ReviewTone.allCases, id: \.self) { item in
                        TitleWithInfoButtonView(
                            title: item.rawValue,
                            isSelected: selectedItem == item,
                            mainAction: {
                                selectedItem = item
                            },
                            infoAction: {
                                currentItem = item
                                DispatchQueue.main.async {
                                    showingInfoSheet = true
                                }
                            })
                        .listRowSeparator(.hidden, edges: .all)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .padding(.vertical, 8)
                
                Button("다음") {
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
        .onAppear {
            selectedItem = reviewFlow.selectedTone
        }
        .sheet(isPresented: $showingInfoSheet) {
            VStack(spacing: 12) {
                Text(currentItem.infoText)
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    Text(currentItem.example)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(height: 250)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                
                Button("닫기") {
                    showingInfoSheet = false
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.orange)
                .padding(.bottom, 16)
            }
            .presentationDetents([.height(350)]) // 팝업 높이 설정
        }
    }
}

#Preview {
    SelectConceptView()
}

struct TitleWithInfoButtonView: View {
    let title: String
    let isSelected: Bool
    let mainAction: () -> Void
    let infoAction: () -> Void
    
    var body: some View {
        HStack(alignment : .center, spacing: 16) {
            Button(action: mainAction) {
                Text(title)
                    .foregroundStyle(isSelected ? .white : .black)
            }
            .buttonStyle(
                OrangeRoundedButtonStyle(
                    width: UIScreen.main.bounds.width * 0.8,
                    height: 60,
                    backgroundColor: isSelected ? .orange : Color.gray.opacity(0.4)
                )
            )
            
            Button(action: infoAction) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
