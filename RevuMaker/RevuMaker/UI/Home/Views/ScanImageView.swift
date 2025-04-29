//
//  ScanImageView.swift
//  RevuMaker
//
//  Created by 김도연 on 4/28/25.
//

import SwiftUI

struct ScanImageView: View {
    @Environment(\.dismiss) private var dismiss
    let image: UIImage

    @State private var scanOffset: CGFloat = -150
    @State private var isNavigate: Bool = false
    @State private var storeData: StoreModel?

    var body: some View {
        VStack {
            ScanningImageView(image: image, scanOffset: $scanOffset)
            Spacer()
            Text("스캔 중입니다")
                .padding(.all, 20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationDestination(isPresented: $isNavigate) {
            if let storeData {
                ConfirmDataView(storeData: storeData, mode: .fromScan)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                storeData = StoreModel(
                    storeName: "맥도날드 홍대점",
                    category: "음식점",
                    productNames: ["빅맥", "더블치즈버거", "감자튀김", "콜라"]
                )
                isNavigate = true
            }
        }
    }
}

private struct ScanningImageView: View {
    let image: UIImage
    @Binding var scanOffset: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width*0.8, height: geo.size.height*0.8)

                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.orange.opacity(0),
                                Color.orange.opacity(0.5),
                                Color.orange.opacity(0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blendMode(.screen)
                    .frame(height: 100)
                    .offset(y: scanOffset)
                    .onAppear {
                        scanOffset = -geo.size.height / 2
                        withAnimation(
                            Animation.linear(duration: 3)
                                .repeatForever(autoreverses: false)
                        ) {
                            scanOffset = geo.size.height / 2
                        }
                    }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    ScanImageView(image: UIImage(systemName: "globe")!)
}
