//
//  SelectConceptView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import SwiftUI

struct SelectConceptView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToMakeRevu = false
    
    let options: [String] = ["친근한 말투", "귀여운 말투", "믿음직한 말투", "아저씨 말투", "트위터 말투(140자 제한)", "블로그 말투"]
    @State private var selectedItem: String?
    
    @State private var showingInfoSheet = false
    @State private var infoText: String = ""
    
    private var buttonAction: () -> Void {
        {
            navigateToMakeRevu = true
            print("버튼 눌림")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text("어떤 말투로 작성할까요?")
                .font(.system(size: 24, weight: .bold))
                .padding(.leading, 24)
            Text("선택지에 따라 말투가 달라져요.\ni버튼을 눌러 말투를 미리 확인해보세요!")
                .font(.system(size: 14, weight: .regular))
                .padding(.leading, 24)
                .padding(.bottom, 24)
                .foregroundStyle(.gray)
            
            VStack(alignment: .center) {
                List {
                    ForEach(options, id: \.self) { item in
                        TitleWithInfoButtonView(title: item, mainAction: {
                            selectedItem = item
                            buttonAction()
                        }, infoAction: {
                            infoText = descriptionForItem(item)
                            showingInfoSheet = true
                        })
                        .listRowSeparator(.hidden, edges: .all)
                        .listRowBackground(Color.clear) // 리스트 배경도 깔끔하게
                    }
                }
                .listStyle(.plain)
                .padding(.vertical, 8)
            }
        }
        .padding(.top, 40)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(action: {
                    dismiss()
                })
            }
        }
        .navigationDestination(isPresented: $navigateToMakeRevu) {
            MakeRevuView()
        }
        .sheet(isPresented: $showingInfoSheet) {
            VStack(spacing: 16) {
                Text(infoText)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .padding()

                Button("닫기") {
                    showingInfoSheet = false
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.orange)
                .padding(.bottom, 16)
            }
            .presentationDetents([.height(200)]) // 팝업 높이 설정
        }
    }
    
    private func descriptionForItem(_ item: String) -> String {
        switch item {
        case "친근한 말투":
            return "편하고 부드럽게 대화하듯 작성하는 말투입니다."
        case "트위터 말투(140자 제한)":
            return "짧고 임팩트 있게, 140자 이내로 작성하는 트위터 스타일 말투입니다."
        case "믿음직한 말투":
            return "신뢰감을 줄 수 있도록 논리적이고 진중한 어투로 작성하는 말투입니다."
        case "블로그 말투":
            return "개인 블로그처럼 자유롭고 자세하게 작성하는 말투입니다."
        default:
            return "설명이 준비되지 않았습니다."
        }
    }
}

#Preview {
    SelectConceptView()
}

struct TitleWithInfoButtonView: View {
    let title: String
    let mainAction: () -> Void
    let infoAction: () -> Void

    var body: some View {
        HStack(alignment : .center, spacing: 16) {
            Button(action: mainAction) {
                Text(title)
            }
            .buttonStyle(OrangeRoundedButtonStyle(width: UIScreen.main.bounds.width * 0.8, height: 60))

            Button(action: infoAction) {
                Image(systemName: "info.circle")
                    .foregroundStyle(.gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
