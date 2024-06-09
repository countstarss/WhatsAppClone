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
    
    static var random : MessageDirection {
        return [MessageDirection.sent ,.received].randomElement() ?? .sent
    }
}

enum MessageType {
    case text,photo,video,audio
    
    var title:String {
        switch self {
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
}
