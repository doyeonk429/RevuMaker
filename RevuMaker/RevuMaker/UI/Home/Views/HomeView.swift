//
//  HomeView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/28/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showImagePicker = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    @State private var navigateToScanImageView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HomeTitleView()
                Spacer()
                HomeImageView()
                Spacer()
                HomeButtonsView(openGallery: openGallery, openCamera: openCamera)
                HomeStartWithoutPhotoButton()
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $navigateToScanImageView) {
                if let selectedImage {
                    ScanImageView(image: selectedImage)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: imagePickerSourceType) { image in
                    self.selectedImage = image
                    self.showImagePicker = false
                    self.navigateToScanImageView = true
                }
            }
        }
    }
    
    private func openGallery() {
        imagePickerSourceType = .photoLibrary
        showImagePicker = true
    }

    private func openCamera() {
        imagePickerSourceType = .camera
        showImagePicker = true
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
    let openGallery: () -> Void
    let openCamera: () -> Void

    var body: some View {
        HStack {
            Spacer()
            HomeActionButton(title: "갤러리", action: openGallery)
            HomeActionButton(title: "카메라", action: openCamera)
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
    @State private var navigateToEmptyConfirm = false

    var body: some View {
        Button {
            navigateToEmptyConfirm = true
        } label: {
            Text("영수증 사진 없이 시작하기")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.gray)
                .underline()
        }
        .navigationDestination(isPresented: $navigateToEmptyConfirm) {
            ConfirmDataView(
                storeData: StoreModel(storeName: "", category: "", productNames: []),
                mode: .fromEmpty
            )
        }
    }
}
