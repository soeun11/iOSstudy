//
//  PhotoManager.swift
//  TCA
//
//  Created by 소은 on 2/10/26.
//
import UIKit
import Photos

struct PhotoManager {
    
    static func requestAuthorization() async -> Bool {
        let auth = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        let authResult = switch auth {
        case .authorized, .limited: true
        default: false
        }
        
        return authResult
    }
    
    static func getAssets() -> [PHAsset] {
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let assetResult = PHAsset.fetchAssets(with: .image, options: option)
        let assets = assetResult.objects(at: .init(0..<assetResult.count))
        
        return assets
    }
    
    static func fetchImage(asset: PHAsset,
                           targetSize: CGSize,
                           completion: @escaping(UIImage?) -> Void
    ) {
      let manager = PHCachingImageManager()
        
        manager.requestImage(for: asset,
                             targetSize: targetSize,
                             contentMode: .aspectFill,
                             options: nil
        ) { image, _ in
            completion(image)
        }
    }
}
