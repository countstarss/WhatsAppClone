//
//  PhotosPickerItem+Extensions.swift
//  CloneChat
//
//  Created by luke on 2024/6/25.
//

import Foundation
import SwiftUI
import PhotosUI

extension PhotosPickerItem {
    var isVideo: Bool{
        let videoUTType: [UTType] = [
            .avi,
            .video,
            .mpeg2Video,
            .mpeg4Movie,
            .movie,
            .quickTimeMovie,
            .audiovisualContent,
            .mpeg,
            .appleProtectedMPEG4Video
        ]
        return videoUTType.contains(where: supportedContentTypes.contains)
        // 这里的`supportedContentTypes`是一个`[UTType]`，表示`PhotosPickerItem`支持的内容类型。
        // `contains(where:)`方法会遍历`videoUTType`数组，并检查`supportedContentTypes`中是否包含任意一个视频类型。
    }
}
