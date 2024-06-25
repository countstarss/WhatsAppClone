//
//  MediaPickerItem+Types.swift
//  CloneChat
//
//  Created by luke on 2024/6/25.
//

import SwiftUI

struct VideoPickerTransferable: Transferable {
    let url:URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { exportingFile in
            // 导出逻辑：使用 FileRepresentation 生成一个文件表示，其中 contentType 指定了文件类型为 .movie。在导出文件时，直接返回文件的 URL
            return .init(exportingFile.url)
        } importing: { receivedTransferredFile in
            // 导入逻辑：在导入文件时，首先获取接收到的文件，然后生成一个唯一的文件名，将文件复制到应用的文档目录中，并返回新的文件 URL
            let originalFile = receivedTransferredFile.file
            let uniqueFileName = "\(UUID().uuidString).mov"
            // 创建文件保存路径
            let copiedFile = URL.documentsDirectory.appendingPathComponent(uniqueFileName)
            // 将文件从收到的原始文件复制到copiedFile
            try FileManager.default.copyItem(at: originalFile, to: copiedFile)
            return .init(url: copiedFile)
        }
    }
}
struct MediaAttachment:Identifiable {
    let id : String
    let type: MediaAttachmentType
    
    var thumbnail: UIImage {
        switch type {
        case .photo(let thumbnail):
            return thumbnail
            
        case .video(let thumbnail,_):
            return thumbnail
            
        case .audio:
            return UIImage()
        }
    }
    
    var fileURL:URL? {
        switch type {
        case .photo:
            return nil
        case .video(_, let fileURL):
            return fileURL
        case .audio:
            // 后面再写audio资源的内容
            return nil
        }
    }
}

enum MediaAttachmentType :Equatable{
    // 图片和视频文件还应该有略缩图thumbnail
    case photo(_ thumbnail: UIImage)
    case video(_ thumbnail: UIImage,_ url: URL)
    case audio
    
    static func ==(lhs:MediaAttachmentType,rhs:MediaAttachmentType) -> Bool {
        switch (lhs,rhs){
        case(.photo,.photo),(.video,.video),(.audio,.audio):
            return true
        default:
            return false
        }
    }
}
