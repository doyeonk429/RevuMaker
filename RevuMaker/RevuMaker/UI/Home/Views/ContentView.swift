//
//  HomeView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/28/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            HomeTitleView()
            Spacer()
            HomeImageView()
            Spacer()
            HomeButtonsView()
            HomeStartWithoutPhotoButton()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}

// MARK: - Subviews

struct HomeTitleView: View {
    var body: some View {
        Text("영수증으로 리뷰 만들기")
            .font(.system(size: 28, weight: .bold))
            .foregroundStyle(.orange)
    }
}

struct HomeImageView: View {
    var body: some View {
        Image(systemName: "globe")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
            .foregroundStyle(.orange)
    }
}

struct HomeButtonsView: View {
    var body: some View {
        HStack {
            Spacer()
            HomeActionButton(title: "갤러리") {
                // gallery action
            }
            HomeActionButton(title: "카메라") {
                // camera action
            }
            Spacer()
        }
    }
}

struct HomeActionButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 150, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange)
                )
        }
        .padding()
    }
}

struct HomeStartWithoutPhotoButton: View {
    var body: some View {
        Button {
            // start without photo action
        } label: {
            Text("영수증 사진 없이 시작하기")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
                .underline()
        }
    }
}
