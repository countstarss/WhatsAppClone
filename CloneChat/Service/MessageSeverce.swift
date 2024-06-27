//
//  MessageSeverce.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/7.
//

import Foundation


//MARK: - handle sending and fetching messages and setting reactions
struct MessageSeverce {
    
    
    //MARK: - sendTextMessage
    static func sendTextMessage(to channel: ChannelItem ,from currentUser: UserItem, _ textMessage :String,completion: () -> Void){
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
    var thumbnail: String?
    var videoURL: String?
    var audioURL: String?
    var audioDuration: TimeInterval
    
}
