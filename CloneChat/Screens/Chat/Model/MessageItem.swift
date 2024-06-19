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
    let text: String
    let type : MessageType
    let ownerUid : String
    let timeStmp : Date
    
    var direction:MessageDirection {
        return ownerUid == Auth.auth().currentUser?.uid ? .sent : .received
    }
    
    static var sentPlaceHolder = MessageItem(
        id: UUID().uuidString,
        text: "sent Holly Spagetiy",
        type:.text,
        ownerUid: "send",
        timeStmp: Date()
    )
    static var receivePlaceHolder = MessageItem(
        id:UUID().uuidString,
        text: "receive Holly Spagetiy",
        type:.text,
        ownerUid: "receive",
        timeStmp: Date()
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
    
    // 静态资源,可以通过struct MessageItem调用
    static let stubMessage: [MessageItem] = [
        MessageItem(id: UUID().uuidString,text: "Hi,there", type: .text,ownerUid: "send", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "check out this photo", type: .photo,ownerUid: "receive", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "Play on this video", type: .video, ownerUid: "receive", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "Hi,there", type: .text, ownerUid: "send", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "Listen to this video", type: .audio, ownerUid: "receive", timeStmp: Date()),
        MessageItem(id: UUID().uuidString,text: "Listen to this video", type: .audio, ownerUid: "send", timeStmp: Date())
    ]
    
}

extension MessageItem {
    init(id:String,dict: [String:Any]){
        self.id = id
        self.text = dict[.text] as? String ?? ""
        let type = dict[.type] as? String ?? "text"
        self.type = MessageType(type)
        self.ownerUid = dict[.ownerUid] as? String ?? ""
        
        let timeInterval = dict[.timeStmp] as? TimeInterval ?? 0
        self.timeStmp = Date(timeIntervalSince1970: timeInterval)
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
