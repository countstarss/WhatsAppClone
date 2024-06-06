//
//  UserService.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/3.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

struct UserService{
    
    
    static func getUser(with uids:[String],completion: @escaping (UserNode)-> Void){
        var users :[UserItem] = []
        for uid in uids {
            let query = FirebaseConstants.UserRef.child(uid)
            query.observeSingleEvent(of: .value) { snapshot in
                guard let user = try? snapshot.data(as: UserItem.self) else { return }
                users.append(user)
                if users.count == uids.count{
                    completion(UserNode(users: users)) // 最后得到的数据是UserNode
                }
            }withCancel: { error in
                completion(.emptyNode)
                print("Failed to get User : \(error.localizedDescription)")
            }
        }
    }

    
    static func paginateUsers(lastCursor:String? ,pageSize: UInt) async throws -> UserNode{
        let mainSnapshot : DataSnapshot
        if lastCursor == nil {
            // 首次获取数据,此时lastCursor为空
            mainSnapshot = try await FirebaseConstants.UserRef.queryLimited(toLast: pageSize).getData()
        }else{
            // 再次直到最后一次
            // mainSnapshot(快照)是获取的原始数据
            mainSnapshot = try await FirebaseConstants.UserRef
                .queryOrderedByKey()
                .queryEnding(atValue: lastCursor)
                .queryLimited(toLast: pageSize + 1)
                .getData()
        }
        
        guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
              let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else { return .emptyNode }
        // userSnapshot(快照)是每个User的原始数据
        // 将每一个userSnapshot转成UserItem的dictionary格式, 最后放到users里边
        // compactMap的作用就是 map循环 以及 打包
        let users : [UserItem] = allObjects.compactMap { userSnapshot in
            let userDict = userSnapshot.value as? [String:Any] ?? [:]
            return UserItem(dictionary: userDict)
        }
        if users.count == mainSnapshot.childrenCount {
            let filteredUsers = lastCursor == nil ? users : users.filter{ $0.uid != lastCursor }
            let userNode = UserNode(users: filteredUsers, currentCursor: first.key)
            return userNode
        }
        return .emptyNode
    }
}

struct UserNode {
    var users: [UserItem]
    var currentCursor : String?
    static let emptyNode = UserNode(users: [], currentCursor: nil)
}
