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
    let thumbnailUrl :String?
    var thumbnailHeight:CGFloat?
    var thumbnailWidth:CGFloat?
    var videoURL:String?
    
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
        sender: .placeholder, thumbnailUrl: "https://firebasestorage.googleapis.com/v0/b/whatsapp-a26a2.appspot.com/o/photo_message%2FC28EC1F6-83FE-42FF-958B-5C82C224DCB3.jpeg?alt=media&token=7dc316ac-5acd-47ef-a779-87347e0c4982"
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
        sender: .placeholder, thumbnailUrl: ""
    )
    static var receivePlaceHolder2 = MessageItem(
        id:UUID().uuidString,
        isGroupChat: false,
        text: "receive Holly Spagetiy",
        type:.video,
        ownerUid: "receive",
        timeStmp: Date(),
        sender: .placeholder, thumbnailUrl: ""
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
    
    var imageSize :CGSize {
        let photoWidth = thumbnailWidth ?? 0
        let photoHeight = thumbnailHeight ?? 0
        let imageHeight = CGFloat(photoHeight / photoWidth * imageWidth)
        return CGSize(width: imageWidth, height: imageHeight)
    }
    
    var imageWidth:CGFloat {
        let photoWidth = (UIWindowScene.current?.screenwidth ?? 0) / 1.5
        return photoWidth
    }
    
    // 静态资源,可以通过struct MessageItem调用
    
    // 不使用init()：适用于简单的静态属性或常量，
    // 可以直接在定义时进行赋值。这样做简洁明了，并且适用于不需要额外初始化逻辑的情况。
    static let stubMessage: [MessageItem] = [
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text,ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "check out this photo", type: .photo,ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Play on this video", type: .video, ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: false,text: "Hi,there", type: .text, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "receive", timeStmp: Date(), sender: .placeholder, thumbnailUrl: ""),
        MessageItem(id: UUID().uuidString, isGroupChat: true,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date(), sender: .placeholder, thumbnailUrl: "")
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
        self.thumbnailUrl = dict[.thumbnailUrl] as? String ?? nil
        self.thumbnailWidth = dict[.thumbnailWidth] as? CGFloat ?? nil
        self.thumbnailHeight = dict[.thumbnailHeight] as? CGFloat ?? nil
        self.videoURL = dict[.videoURL] as? String ?? nil
    }
}


// 将enum类型全部迁移到Types文件中

// 这样主要是为了防止拼写错误,将String作为String选项不容易出错
extension String{
    static let text = "text"
    static let type = "type"
    static let timeStmp = "timeStmp"
    static let ownerUid = "ownerUid"
    static let thumbnailWidth = "thumbnailWidth"
    static let thumbnailHeight = "thumbnailHeight"
    static let videoURL = "videoURL"
}
