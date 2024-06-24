//
//  MessageItem.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI
import Firebase

struct MessageItem:Identifiable{
    
    let id :String
    let isGroupChat :Bool
    let text: String
    let type : MessageType
    let ownerUid : String
    let timeStmp : Date
    let sender : UserItem?
    
    var direction:MessageDirection {
        return ownerUid == Auth.auth().currentUser?.uid ? .sent : .received
    }
    
    static var sentPlaceHolder = MessageItem(
        id: UUID().uuidString,
        isGroupChat: true,
        text: "sent Holly Spagetiy",
        type:.text,
        ownerUid: "send",
        timeStmp: Date(),
        sender: .placeholder
        // direction: .sent
        // direction作为一个计算属性，而不再是属性
    )
    static var receivePlaceHolder = MessageItem(
        id:UUID().uuidString,
        isGroupChat: false,
        text: "receive Holly Spagetiy",
        type:.text,
        ownerUid: "receive",
        timeStmp: Date(),
        sender: .placeholder
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
    
    var degree : Double {
        return direction == .sent ? -15 : 15
    }
    // 控制BubbleText中的头像显示
    var showGroupPartnerInfo : Bool {
        return isGroupChat && direction == .received
    }
    // 控制MESSAGE的padding，也就是显示的长度
    var leadingPadding:CGFloat {
        return direction == .received ? 0 : horizontalPadding
    }
    
    var trailingPadding:CGFloat {
        return direction == .received ? horizontalPadding : 0
    }
    
    private let horizontalPadding:CGFloat = 25
    
    // 静态资源,可以通过struct MessageItem调用
    
    // 不使用 init()：适用于简单的静态属性或常量，可以直接在定义时进行赋值。这样做简洁明了，并且适用于不需要额外初始化逻辑的情况。
    static let stubMessage: [MessageItem] = [
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text,ownerUid: "send", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "check out this photo", type: .photo,ownerUid: "receive", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Play on this video", type: .video, ownerUid: "receive", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text, ownerUid: "send", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "receive", timeStmp: Date(), sender: .placeholder),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder)
    ]
    
}

extension MessageItem {
    init(id:String,dict: [String:Any],isGroupChat: Bool,sender:UserItem){
        self.id = id
        self.isGroupChat = isGroupChat
        self.text = dict[.text] as? String ?? ""
        let type = dict[.type] as? String ?? "text"
        self.type = MessageType(type) ?? .text
        self.ownerUid = dict[.ownerUid] as? String ?? ""
        
        let timeInterval = dict[.timeStmp] as? TimeInterval ?? 0
        self.timeStmp = Date(timeIntervalSince1970: timeInterval)
        self.sender = sender
    }
}


// 将enum类型全部迁移到Types文件中

// 这样主要是为了防止拼写错误,将String作为String选项不容易出错
extension String{
    static let text = "text"
    static let type = "type"
    static let timeStmp = "timeStmp"
    static let ownerUid = "ownerUid"
}
