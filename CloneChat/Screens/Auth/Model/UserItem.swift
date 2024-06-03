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
    
    static let placeholders : [UserItem] = [
            UserItem(uid: "1", username: "Luke", email: "swiftSkool@gamil.com"),
            UserItem(uid: "2", username: "smith", email: "smith@gamil.com"),
            UserItem(uid: "3", username: "John", email: "John@gamil.com"),
            UserItem(uid: "4", username: "Lily", email: "Lily@gamil.com"),
            UserItem(uid: "5", username: "curl", email: "curl@gamil.com"),
            UserItem(uid: "6", username: "bob", email: "swiftSkool@gamil.com"),
            UserItem(uid: "7", username: "bill", email: "jobs@gamil.com"),
            UserItem(uid: "8", username: "locus", email: "locus@gamil.com"),
            UserItem(uid: "9", username: "jonas", email: "locus@gamil.com"),
            UserItem(uid: "10", username: "jams", email: "swiftSkool@gamil.com"),
            UserItem(uid: "11", username: "jobs", email: "jobs@gamil.com"),
            UserItem(uid: "12", username: "clair", email: "clair@gamil.com"),
        ]
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
