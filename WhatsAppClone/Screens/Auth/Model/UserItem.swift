//
//  UserItem.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation


// 用户模型
struct UserItem :Identifiable,Hashable,Decodable{
    let uid: String
    let username:String
    let email:String
    var bio:String? = nil
    var profileImageUrl:String? = nil
    
    var id:String {
        return uid
    }
    
    var bioUnwrapped:String{
        return bio ?? "Hey there i'm using WhatsApp"
    }
    
    static let placeholder = UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com")
}


// 字典映射
extension UserItem{
    init(dictionary :[String : Any]) {
        self.uid = dictionary[.uid] as? String ?? ""
        self.username = dictionary[.username] as? String ?? ""
        self.email = dictionary[.email] as? String ?? ""
        self.bio = dictionary[.bio] as? String ?? nil
        self.profileImageUrl = dictionary[.profileImageUrl] as? String ?? nil
    }
}

extension String{
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}
