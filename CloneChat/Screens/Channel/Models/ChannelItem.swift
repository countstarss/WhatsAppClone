//
//  ChannelItem.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation
import Firebase

struct ChannelItem :Identifiable,Hashable{
    var id:String
    var name:String?
    var lastMessage :String
    var creationDate :Date
    var lastMessageTimeStmp:Date
    var membersCount:Int
    var adminUids: [String]
    var membersUids :[String]
    var members : [UserItem] //fetch
    private var thumbnailUrl :String?
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
    
    //MARK: - 以下两个用于添加AdminMessage
    var isCreatedByMe: Bool {
        return createdBy == Auth.auth().currentUser?.uid ?? ""
    }
    
    var creatorName: String {
        // 这快有点问题，找不到实际的创建者
        return members.first {$0.uid == createdBy}?.username ?? "Someone"
    }
    
    // 对thumbnailUrl进行进一步封装，实现判断功能
    var coverImageUrl:String? {
        if let thumbnailUrl = thumbnailUrl{
            return thumbnailUrl
        }
        
        if isGroupChat == false {
            // 如果不是群聊，那么直接返回除了我之外的另外一个人的profileImageView
            return membersExcludingMe.first?.profileImageUrl
        }
        
        return nil
    }
    
    private var groupMembersNames:String {
        let membersCount = membersCount - 1
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
    
    // 使用 init() 方法。这种方法会在类加载时立即执行初始化操作，并保证静态属性在类第一次访问之前已经被初始化
    
    // 使用 init()：适用于需要在类加载时立即执行初始化操作的情况，允许您在初始化闭包中进行复杂的计算或初始化逻辑。这种方式确保了静态资源在第一次访问之前已经准备好使用。
    // 不使用 init()：适用于简单的静态属性或常量，可以直接在定义时进行赋值。这样做简洁明了，并且适用于不需要额外初始化逻辑的情况。
    static let placeholder = ChannelItem.init(
        id: "1",
        lastMessage: "Hello world",
        creationDate: Date(),
        lastMessageTimeStmp: Date(),
        membersCount: 3,
        adminUids: [],
        membersUids: [],
        members: [UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com"),
                  UserItem(uid: "2", username: "smith", email: "smith@gamil.com")],
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
