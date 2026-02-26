//
//  EditImageView.swift
//  TCA
//
//  Created by 소은 on 2/20/26.
//

import SwiftUI
import SwiftData

import ComposableArchitecture
import Photos

struct AssestImageView: View {
    let assest: PHAsset
    let isSelected: Bool
    let onTap: (Data) -> Void

    @State private var image: UIImage? = nil
    @Environment(\.displayScale) private var scale

    var body: some View {
        GeometryReader { geo in
            let side = geo.size.width
            let pixelSize = CGSize(width: side * scale,
                                     height: side * scale)
            
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray.opacity(0.2)
                }
            }
            .frame(width: side, height: side)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .topTrailing) {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                        .padding(6)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if let image, let data = image.jpegData(compressionQuality: 1.0) {
                    onTap(data)
                }
            }
            .task(id: assest.localIdentifier) {
                PhotoManager.fetchImage(asset: assest, targetSize: pixelSize) { uiimage in
                    image = uiimage
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
