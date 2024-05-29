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
    let direction:MessageDirection
    
    static var sentPlaceHolder = MessageItem(
        text: "sent Holly Spagetiy",
        direction: .sent
    )
    static var receivePlaceHolder = MessageItem(
        text: "receive Holly Spagetiy",
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
    
}

enum MessageDirection{
    case sent,received
    
    static var random : MessageDirection {
        return [MessageDirection.sent ,.received].randomElement() ?? .sent
    }
}
