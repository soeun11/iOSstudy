//
//  EditImageView.swift
//  TCA
//
//  Created by 소은 on 2/20/26.
//
import SwiftUI
import SwiftData

import ComposableArchitecture

struct AssestImageView: View {
    let assest: PHAsset
    let isSelected: Bool
    let onTap: (Data) -> Void
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        GeometryReader { geo in
            let imageWidth = geo.size.width
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageWidth, height: imageWidth)
                } else {
                    Color.gray.opacity(0.2)
                        .frame(width: imageWidth, height: imageWidth)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .overlay(alignment: .topTrailing) {
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.green)
                    .frame(width: 20, height: 20)
            }
        }
        .onTapGesture {
            if let image, let data = image.jpegData(compressionQuality: 1.0) {
                onTap(data)
            }
        }
        .onAppear {
            PhotoManager.fetchImage(asset: assest) { uiimage in
                image = uiimage
            }
        }
    }
}
