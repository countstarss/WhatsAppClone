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
}
