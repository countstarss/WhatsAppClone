//
//  ChannelItem.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation

struct ChannelItem :Identifiable{
    var id:String
    var name:String?
    var lastMessage :String
    var creationDate :Date
    var lastMessageTimeStmp:Date
    var membersCount:UInt
    var adminUids: [String]
    var membersUids :[String]
    var members : [UserItem] //fetch
    var thumbnailUrl :String?
    
    var isGroupChat: Bool {
        return membersCount > 2
    }
    
    static let placeholder = ChannelItem.init(
        id: "1",
        lastMessage: "Hello world",
        creationDate: Date(),
        lastMessageTimeStmp: Date(),
        membersCount: 2,
        adminUids: [],
        membersUids: [],
        members: []
    )
}
