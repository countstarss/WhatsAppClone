//
//  ChannelTabViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation
import Firebase

//MARK: - 添加channelRoutes
enum ChannelTabRoutes: Hashable {
    case chatRoom(_ channel: ChannelItem)
}

// 使用final 将其设置为静态类
final class ChannelTabViewModel: ObservableObject {
    
    @Published var navRoutes = [ChannelTabRoutes]()
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerScreen = false
    @Published var channels = [ChannelItem]()
    // channelDictionary用来存放所有的channel
    typealias ChannelId = String
    @Published var channelDictionary : [ChannelId: ChannelItem] = [:]
    
    // 用于向fetch到的channel中添加当前登录用户
    private var currentUser : UserItem
    
    func onNewChannelCreation(_ channel:ChannelItem) {
        showChatPartnerPickerScreen = false
        newChannel = channel
        navigateToChatRoom = true
    }
    
    // 添加currentUser，依赖注入
    init(_ currentUser: UserItem){
        self.currentUser = currentUser
        channels.removeAll()
        fetchCurrentUserChannels()
    }
    
    // 在Swift中，[weak self]的作用是在闭包中捕获self并且避免循环引用。
    // 当在闭包内部引用了self时，如果使用[weak self]，则表示该闭包对self是弱引用的，不会增加self的引用计数，
    // 因此在闭包执行时，如果self已经被释放了，那么该闭包内部对self的引用会自动被置为nil，避免了循环引用导致的内存泄漏问题
    
    //MARK: - fetchCurrentUserChannels
    func fetchCurrentUserChannels() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        FirebaseConstants.UserChannelRef.child(currentUid).observe(DataEventType.value, with:{ [weak self] snapshot in
            do{
                guard let dict = snapshot.value as? [String: Any] else { return }
                // 这里得到的snapshot是一个键值对
                dict.forEach { key, value in
                    let channelId = key
                    self?.getChannel(with: channelId)
                }
            }
        })
        
    }
    
//    private func listenToAuthState() {
//        AuthManager.shared.authState.receive(on: DispatchQueue.main).sink{ [weak self] authState in
//            guard let self = self else { return }
//            switch authState{
//                // 如果通过Firebase Auth拿到当前的登陆状态是LogedIn
//            case .loggedIn(let current):
//                self.currentUser = current
//                // 如果不需要fetch，直接调用getMessage()
//                
//                // 导致无法正确判断allMembersFetched是否为true的原因是：
//                    // 在ChannelTabViewModel中获取Channel时，没有把当前user添加进去,导致channel只有一个
//                if self.channel.allMembersFetched{
//                    print("allMembersFetched")
//                    self.getMessage()
//                }else {
//                    print("in else")
//                    // 改变顺序，先获取所有的channelMembers，然后在fetchAllChannelMembers函数里getMessage
//                    self.fetchAllChannelMembers()
//                }
//            default :
//                break
//            }
//            //
//        }.store(in: &subScriptions)
//    }
    
    //MARK: - getChannel
    private func getChannel(with channelId: String) {
        FirebaseConstants.ChannelRef.child(channelId).observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String : Any] else { return }
            guard let seff = self else { return } // 使用seff代替self，解开self，这样才能
            var channel = ChannelItem(dict)
            seff.getChannelMembers(channel) { members in
                channel.members = members
                // 所有的情况都添加currentUser
                channel.members.append(seff.currentUser) // 使用seff代替self，解开self，这样才能添加currentUser
                seff.channelDictionary[channelId] = channel
                seff.reloadData()
//                self?.channels.append(channel)
//                print("Channel: \(channel.members.map {$0.})")
            }
        } withCancel: { error in
            print("🙅🏻 Failed to get the channel for id \(channelId) :\(error.localizedDescription)")
        }
    }
    
    //MARK: - getChannelMembers
    func getChannelMembers(_ channel: ChannelItem, completion: @escaping (_ members: [UserItem])-> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let channelMemberUids = Array(channel.membersUids.filter{$0 != currentUid}.prefix(2))
        UserService.getUser(with: channelMemberUids) { userNode in
            completion(userNode.users) // 得到的是[UserItem]
        }
    }
    
    private func reloadData() {
        self.channels = Array(channelDictionary.values)
        self.channels.sort{ $0.lastMessageTimeStmp > $1.lastMessageTimeStmp }
    }
}


