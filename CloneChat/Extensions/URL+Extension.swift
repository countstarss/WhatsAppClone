//
//  URL+Extension.swift
//  CloneChat
//
//  Created by luke on 2024/6/25.
//

import Foundation
import AVFoundation
import UIKit

extension URL{
    
    func generateVideoThumbnail() async throws -> UIImage? {
        // 设置好资源和Generator
        let asset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        // 设置 appliesPreferredTrackTransform 为 true 以确保生成的图像具有正确的方向
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 1, preferredTimescale: 60)
        
        return try await withCheckedThrowingContinuation { continuation in
            imageGenerator.generateCGImageAsynchronously(for: time) { cgImage, _, error in
                if let cgImage = cgImage {
                    let thumbnailImage = UIImage(cgImage: cgImage)
                    continuation.resume(returning: thumbnailImage)
                }else {
                    continuation.resume(throwing: error ?? NSError(domain: "", code: 0, userInfo: nil))
                }
            }
        }
    }
    
    static var stubURL: URL {
        return URL(string: "https://github.com")!
    }
}

