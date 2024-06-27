//
//  FirebaseHelper.swift
//  CloneChat
//
//  Created by luke on 2024/6/27.
//

import Foundation
import UIKit
import FirebaseStorage

// completion是跟在函数后面的内容，可以用它来返回想要的数据，当前我们上传之后，如果成功，返回URL，如果失败，返回Error
typealias UploadCompletion = (Result<URL,Error>) -> Void
// 再添加一个completion，用来返回上传进度
typealias ProgressHandler = (Double) -> Void

enum UploadError: Error{
    case failedToUploadImage(_ description :String)
    case failedToUploadFile(_ description :String)
}

extension UploadError: LocalizedError {
    var errorDescription :String? {
        switch self {
        case .failedToUploadImage(let description):
            return description
        case .failedToUploadFile(let deacription):
            return deacription
        }
    }
}
    
struct FirebaseHelper {
    
    // 上传prifile 和 所有的thumbnail
    static func uploadImage(
        _ image: UIImage,
        for type: UploadType,
        completion: @escaping UploadCompletion,
        progressHandler: @escaping ProgressHandler) {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            
            let storageRef = type.filePath
            let uploadTask = storageRef.putData(imageData){ _,error in
                if let error = error {
                    print("Filed to upload image to storage\(error.localizedDescription)")
                    completion(.failure(UploadError.failedToUploadImage(error.localizedDescription)))
                    return
                }
                storageRef.downloadURL(completion: completion) // 意思是继续调用后面的completion
            }
            // 第二个completion用来计算presress
            uploadTask.observe(.progress) { snapshot in
                guard let progress = snapshot.progress else { return }
                let percentage = Double(progress.completedUnitCount / progress.totalUnitCount)
                progressHandler(percentage)
            }
        }
    
    static func uploadFile(
        for type:UploadType,
        fileURL: URL,
        completion: @escaping UploadCompletion,
        progressHandler: @escaping ProgressHandler) {
            
            let storageRef = type.filePath
            let uploadTask = storageRef.putFile(from: fileURL){ _,error in
                if let error = error {
                    print("Filed to upload File to storage\(error.localizedDescription)")
                    completion(.failure(UploadError.failedToUploadFile(error.localizedDescription)))
                    return
                }
                storageRef.downloadURL(completion: completion) // 意思是继续调用后面的completion
            }
            // 第二个completion用来计算presress
            uploadTask.observe(.progress) { snapshot in
                guard let progress = snapshot.progress else { return }
                let percentage = Double(progress.completedUnitCount / progress.totalUnitCount)
                progressHandler(percentage)
            }
        }
}

extension FirebaseHelper {
    enum UploadType {
        case profile
        case photoMessage
        case videoMessage
        case voiceMessage
        
        
        var filePath: StorageReference {
            let filename = UUID().uuidString
            switch self {
            case .profile:
                return FirebaseConstants.StorageRef.child("profile_image_urls").child(filename)
            case .photoMessage:
                return FirebaseConstants.StorageRef.child("photo_message").child(filename)
            case .videoMessage:
                return FirebaseConstants.StorageRef.child("video_message").child(filename)
            case .voiceMessage:
                return FirebaseConstants.StorageRef.child("voice_message").child(filename)
            }
        }
    }
}

