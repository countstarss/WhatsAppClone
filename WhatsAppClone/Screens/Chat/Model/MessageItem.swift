//
//  MessageItem.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct MessageItem:Identifiable{
    
    let id = UUID().uuidString
    let text: String
    let type : MessageType
    let direction:MessageDirection
    
    static var sentPlaceHolder = MessageItem(
        text: "sent Holly Spagetiy", type:.text,
        direction: .sent
    )
    static var receivePlaceHolder = MessageItem(
        text: "receive Holly Spagetiy", type: .text,
        direction: .received
    )
    
    var alignment: Alignment{
        return direction == .received ? .leading : .trailing
    }
    
    var horizontalAlignment: HorizontalAlignment{
        return direction == .received ? .leading : .trailing
    }
    
    var backgroundColor:Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    
    // 静态资源,可以通过struct MessageItem调用
    static let stubMessage: [MessageItem] = [
        MessageItem(text: "Hi,there", type: .text, direction: .sent),
        MessageItem(text: "check out this photo", type: .photo, direction: .received),
        MessageItem(text: "Play on this video", type: .video, direction: .sent),
        MessageItem(text: "Listen to this video", type: .audio, direction: .sent)
    ]
    
}

enum MessageDirection{
    case sent,received
    
    static var random : MessageDirection {
        return [MessageDirection.sent ,.received].randomElement() ?? .sent
    }
}

enum MessageType {
    case text,photo,video
//    case audio
}
