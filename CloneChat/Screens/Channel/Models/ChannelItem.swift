//
//  ChannelItem.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation
import Firebase

struct ChannelItem :Identifiable{
    var id:String
    var name:String?
    var lastMessage :String
    var creationDate :Date
    var lastMessageTimeStmp:Date
    var membersCount:Int
    var adminUids: [String]
    var membersUids :[String]
    var members : [UserItem] //fetch
    var thumbnailUrl :String?
    let createdBy :String
    
    var isGroupChat: Bool {
        return membersCount > 2
    }
    // 下面代码的目的是给ChatRoomScreen提供title接口
    var membersExcludingMe : [UserItem]{
        guard let currentUid = Auth.auth().currentUser?.uid else{ return [] }
        return members.filter{ $0.uid != currentUid }
    }
    
    var title :String{
        if let name = name {
            return name
        }
        if isGroupChat{
            return groupMembersNames
        }else{
            return membersExcludingMe.first?.username ?? "UnKnown"
        }
        
        
    }
    
    private var groupMembersNames:String {
        let membersCount = membersExcludingMe.count
        let fullNames :[String] = membersExcludingMe.map{ $0.username }
        
        if membersCount == 2 {
            return fullNames.joined(separator: " and ")
        }else if membersCount > 2 {
            // example : luke, jonas, and 4 others
            let remainingCount =  membersCount - 2
            return fullNames.prefix(2).joined(separator: ", ") + ", and \(remainingCount) " + "others"
        }
        return "UnKnown"
    }
    
    static let placeholder = ChannelItem.init(
        id: "1",
        lastMessage: "Hello world",
        creationDate: Date(),
        lastMessageTimeStmp: Date(),
        membersCount: 2,
        adminUids: [],
        membersUids: [],
        members: [],
        createdBy: ""
    )
}

// 确保ChannelItem可以接收dict
extension ChannelItem {
    init(_ dict :[String :Any]) {
        self.id = dict[.id] as? String ?? ""
        self.name = dict[.name] as? String
        self.lastMessage = dict[.lastMessage] as? String ?? ""
        
        let creationInterval = dict[.creationDate] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: creationInterval)
        
        let lastMsgTimeStmpInterval = dict[.lastMessageTimeStmp] as? Double ?? 0
        self.lastMessageTimeStmp = Date(timeIntervalSince1970: lastMsgTimeStmpInterval)
        
        self.membersCount = dict[.membersCount] as? Int ?? 0
        self.adminUids = dict[.adminUids] as? [String] ?? []
        self.thumbnailUrl = dict[.thumbnailUrl] as? String ?? nil
        self.membersUids = dict[.membersUids] as? [String] ?? []
        self.members = dict[.members] as? [UserItem] ?? []
        self.createdBy = dict[.createdBy] as? String ?? ""
    }
}

extension String{
    static let id = "id"
    static let name = "name"
    static let lastMessage = "lastMessage"
    static let creationDate = "creationDate"
    static let lastMessageTimeStmp = "lastMessageTimeStmp"
    static let membersCount = "membersCount"
    static let adminUids = "adminUids"
    static let membersUids = "membersUids"
    static let thumbnailUrl = "thumbnailUrl"
    static let members = "members"
    static let createdBy = "createdBy"
    
}
