//
//  MessageItems+Types.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/5.
//

import Foundation

enum AdminMessageType:String{
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
}

enum MessageDirection{
    case sent,received
    
    // 静态方法，链式调用
    static var random : MessageDirection {
        return [MessageDirection.sent ,.received].randomElement() ?? .sent
    }
}

enum MessageType{
    case admin(_ type: AdminMessageType),text,photo,video,audio
    
    var title:String {
        switch self {
        case .admin(_):
            return "admin"
        case .text:
            return "text"
        case .photo:
            return "photo"
        case .video:
            return "video"
        case .audio:
            return "audio"
        
        }
    }
    
    //MARK: - 使用外部字符串初始化MessageType
    //功能： 本来MessageType是需要传入enum类型的，通过这个初始化，可以传入字符串，自动返回enum类型
    init?(_ stringVlue :String) {
        switch stringVlue {
        case "text":
            self = .text
        case "photo":
            self = .photo
        case "video":
            self = .video
        case "audio":
            self = .audio
        default:
            if let adminMessageType = AdminMessageType(rawValue: stringVlue) {
                self = .admin(adminMessageType)
            }else {
                return nil
            }
        }
    }
}

extension MessageType:Equatable {
    static func ==(lhs:MessageType, rhs:MessageType) -> Bool {
        switch(lhs,rhs) {
        case (.admin(let leftAdmin),.admin(let rightAdmin)):
            return leftAdmin == rightAdmin
            
        case (.text,.text),
            (.photo,.photo),
            (.video,.video),
            (.audio,.audio):
            return true
            
        default :
            return false
        }
    }
}
