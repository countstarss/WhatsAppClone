//
//  MessageSeverce.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/7.
//

import Foundation


//MARK: - handle sending and fetching messages and setting reactions
struct MessageService {
    
    
    //MARK: - sendTextMessage
    static func sendTextMessage(to channel: ChannelItem ,from currentUser: UserItem,_ textMessage :String,completion: () -> Void
    ){
        // 02
        let timeStmp = Date().timeIntervalSince1970
        guard let messageId = FirebaseConstants.MessageRef.childByAutoId().key else { return }
        
        let channelDict:[String : Any] = [
            .lastMessage:textMessage,
            .lastMessageTimeStmp: timeStmp,
        ]
        let messageDict: [String : Any] = [
            .text :textMessage,
            .type: MessageType.text.title,
            .timeStmp: timeStmp,
            .ownerUid: currentUser.uid
        ]
        
        // 03
        FirebaseConstants.ChannelRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessageRef.child(channel.id).child(messageId).setValue(messageDict)
        
        
        completion()
    }
    
    
    static func sendMediaMessage(
        to channel :ChannelItem,
        params: MessageUploadParams,
        completion: @escaping () -> Void
    ) {
        let timeStmp = Date().timeIntervalSince1970
        guard let messageId = FirebaseConstants.MessageRef.childByAutoId().key else { return }
        
        // 01
        let channelDict:[String : Any] = [
            .lastMessage:params.text,
            .lastMessageTimeStmp: timeStmp,
            .lastMessageType:params.type.title
        ]
        // 02
        var messageDict: [String : Any] = [
            .text :params.text,
            .type: params.type.title,
            .timeStmp: timeStmp,
            .ownerUid: params.ownerUid
        ]

        messageDict[.thumbnailUrl] = params.thumbnailUrl ?? nil
        messageDict[.thumbnailWidth] = params.thumbnailWidth ?? nil
        messageDict[.thumbnailHeight] = params.thumbnailHeight ?? nil
        // 03
        FirebaseConstants.ChannelRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessageRef.child(channel.id).child(messageId).setValue(messageDict)
        
        completion() // 调用后续闭包中的函数，不传入参数
    }
    
    static func getMessages(for channel :ChannelItem,completion: @escaping([MessageItem])-> Void) {
        FirebaseConstants.MessageRef.child(channel.id).observe(.value){ snapshot in
            var messages : [MessageItem] = [MessageItem]()
            guard let dict = snapshot.value as? [String:Any] else { return }
            dict.forEach { key,value in
                let messageDict = value as? [String: Any] ?? [:]
                let message = MessageItem(id: key, dict: messageDict, isGroupChat: channel.isGroupChat,sender: .placeholder)
                messages.append(message)
                messages.sort { $0.timeStmp < $1.timeStmp }
                // 使用completion将调用这个函数的函数所需要的变量传过去！
                completion(messages)
            }
        }withCancel: { error in
            print("Failed to get message for \(channel.title),error :\(error.localizedDescription)")
        }
    }
    
}

// 创建MessageUploadParams
struct MessageUploadParams {
    let channel :ChannelItem
    let text: String
    let type: MessageType
    let attachment: MediaAttachment
    
    var sender :UserItem
    var thumbnailUrl: String?
    var videoURL: String?
    var audioURL: String?
    var audioDuration: TimeInterval?
    
    var ownerUid:String {
        return sender.uid
    }
    
    var thumbnailWidth: CGFloat? {
        guard type == .photo || type == .video else { return nil }
        return attachment.thumbnail.size.width
    }
    
    var thumbnailHeight: CGFloat? {
        guard type == .photo || type == .video else { return nil }
        return attachment.thumbnail.size.height
    }
    
}
