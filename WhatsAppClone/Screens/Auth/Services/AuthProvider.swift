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
    // 向loggedIn 添加UserItem,以至于我们可以知道是哪个用户处于登陆状态
    case pending, loggedIn(UserItem), loggedOut
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

enum AuthError: Error{
    case accountCreationFailed(_ description :String)
    case failedToSaveUserInfo(_ description :String)
}

extension AuthError: LocalizedError {
    var errorDescription :String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedToSaveUserInfo(let description):
            return description
        }
    }
}


// Singleten 单例
final class AuthManager:AuthProvider {
    
    private init(){
        Task { await autoLogin() }
    }
    /// 00
    static let shared :AuthProvider = AuthManager()
    
    var authState = CurrentValueSubject<AuthState, Never>(.pending)
    
    func autoLogin() async {
        //
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        }else{
            fetchCurrentUserInfo()
        }
    }
    func login(with email: String, and password: String) async throws {
            
    }
    func createAccount(for username: String, with email: String, and password: String) async throws {

        do{
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = authResult.user.uid
            let newUser = UserItem(uid: uid, username: username, email: email)
            /// 02
            try await saveUserInfoDatabase(user: newUser)
            // 把newUser放进authState中的loggedIn状态里
            self.authState.send(.loggedIn(newUser))
        }catch{
            print("🔞 :Failed to create a account:\(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    func logOut() async throws {
        do{
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔞 :successfully to log out")
        }catch{
            print("🔞 :Failed to log out current user:\(error.localizedDescription)")
        }
    }
}
/// 01
extension AuthManager {
    private func saveUserInfoDatabase(user: UserItem) async throws {
        do{
            // 因为在userItem中已经声明了String的extension ,所以后边的String类型都可以替代
            let userDictionary :[String : Any] = [.uid: user.uid, .username: user.username, .email:user.email]
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictionary)
        }catch{
            print("🔞 :Failed to save user info to database:\(error.localizedDescription)")
            throw AuthError.failedToSaveUserInfo(error.localizedDescription)
        }
    }
    
    // 获取当前用户
    private func fetchCurrentUserInfo() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        // 用声明的常量 FirebaseConstants.UserRef 代替原来的写法
        FirebaseConstants.UserRef.child(currentUid).observe(.value) { [weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String :Any] else {return}
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔞 :\(loggedInUser.username) is logged")
            
        } withCancel: { error in
            print("Failed to get current user info")
        }
    }
}

/// 00 将UserItem提取到一个单独的Model文件中
// 用户模型
//struct UserItem :Identifiable,Hashable,Decodable{
//    let uid: String
//    let username:String
//    let email:String
//    var bio:String? = nil
//    var profileImageUrl:String? = nil
//    
//    var id:String {
//        return uid
//    }
//    
//    var bioUnwrapped:String{
//        return bio ?? " Hey there i'm using WhatsApp"
//    }
//}
//
//
//// 字典映射
//extension UserItem{
//    init(dictionary :[String : Any]) {
//        self.uid = dictionary[.uid] as? String ?? ""
//        self.username = dictionary[.username] as? String ?? ""
//        self.email = dictionary[.email] as? String ?? ""
//        self.bio = dictionary[.bio] as? String ?? nil
//        self.profileImageUrl = dictionary[.profileImageUrl] as? String ?? nil
//    }
//}
//
//extension String{
//    static let uid = "uid"
//    static let username = "username"
//    static let email = "email"
//    static let bio = "bio"
//    static let profileImageUrl = "profileImageUrl"
//}
