//
//  AuthProvider.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState{
    case pending, loggedIn, loggedOut
}
/// 00
protocol AuthProvider{
    // 在这里写AuthProvider能做些什么
    
    static var shared :AuthProvider { get }
    var authState :CurrentValueSubject<AuthState, Never> { get }
    func autoLogin() async
    func login(with email:String, and password:String) async throws
    func createAccount(for username:String ,with email :String ,and password :String) async throws
    func logOut() async throws
}


// Singleten 单例
final class AuthManager:AuthProvider {
    
    private init(){
        
    }
    /// 00
    static let shared :AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        
    }
    func login(with email: String, and password: String) async throws {
            
    }
    func createAccount(for username: String, with email: String, and password: String) async throws {
        // invoke firebase create account method : store the new user info in our firebase auth
        
        
        // store the new user info in our database
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        print("创建用户实体")
        let newUser = UserItem(uid: uid, username: username, email: email)
        /// 02
        print("接下来就是向数据库中存储用户数据")
        try await saveUserInfoDatabase(user: newUser)
    }
    func logOut() async throws {
        
    }
}
/// 01
extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        let userDictionary = ["uid": user.uid, "username": user.username, "email":user.email]
        try await Database.database(url:"https://whatsapp-a26a2-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("user").child(user.uid).setValue(userDictionary)
    }
}

/// 00
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
        return bio ?? " Hey there i'm using WhatsApp"
    }
}
