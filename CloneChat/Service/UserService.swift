//
//  UserService.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/3.
//

import Foundation
import Firebase
import FirebaseDatabase


struct UserService{
    
    static func paginateUsers(lastCursor:String? ,pageSize: UInt) async throws -> UserNode{
        print("paginateUsers")
        if lastCursor == nil {
            // initial data fetch
            print("get in first time")
            let mainSnapshot = try await FirebaseConstants.UserRef.queryLimited(toLast: pageSize).getData()
            guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
                  let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else { return .emptyNode }
            
            let users : [UserItem] = allObjects.compactMap { userSnapshot in
                let userDict = userSnapshot.value as? [String:Any] ?? [:]
                return UserItem(dictionary: userDict)
            }
            if users.count == mainSnapshot.childrenCount {
                print("userNode <- UserNode [0]")
                let userNode = UserNode(users: users, currentCursor: first.key)
                return userNode
            }
            return .emptyNode
        }else {
            print("ELSE")
//            let mainSnapshot = try await FirebaseConstants.UserRef
//                .queryOrderedByKey()
//                .queryEnding(atValue: lastCursor)
//                .queryLimited(toLast: pageSize)
//                .getData()
            
            let mainSnapshot = try await FirebaseConstants.UserRef.queryOrderedByKey(
            ).queryEnding(
                atValue: lastCursor
            ).queryLimited(
                toLast: pageSize + 1
            ).getData()
            
            guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
                  let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else { return .emptyNode }
            
            let users : [UserItem] = allObjects.compactMap { userSnapshot in
                let userDict = userSnapshot.value as? [String:Any] ?? [:]
                return UserItem(dictionary: userDict)
            }
            if users.count == mainSnapshot.childrenCount {
                print("userNode <- UserNode [more]")
                let filteredUsers = users.filter{ $0.uid != lastCursor }
                let userNode = UserNode(users: filteredUsers, currentCursor: first.key)
                return userNode
            }
            // 如果一直没有返回,走到了最后,就返回空节点
            return .emptyNode
        }
    }
}

struct UserNode {
    var users: [UserItem]
    var currentCursor : String?
    static let emptyNode = UserNode(users: [], currentCursor: nil)
}
