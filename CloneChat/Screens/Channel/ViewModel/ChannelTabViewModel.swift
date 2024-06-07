//
//  ChannelTabViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation
import Firebase

// 使用final 将其设置为静态类
final class ChannelTabViewModel: ObservableObject {
    
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerScreen = false
    @Published var channels = [ChannelItem]()
    // channelDictionary用来存放所有的channel
    typealias ChannelId = String
    @Published var channelDictionary : [ChannelId: ChannelItem] = [:]
    
    func onNewChannelCreation(_ channel:ChannelItem) {
        showChatPartnerPickerScreen = false
        newChannel = channel
        navigateToChatRoom = true
    }
    
    init(){
        channels.removeAll()
        fetchCurrentUserChannels()
    }
    
    // 在Swift中，[weak self]的作用是在闭包中捕获self并且避免循环引用。
    // 当在闭包内部引用了self时，如果使用[weak self]，则表示该闭包对self是弱引用的，不会增加self的引用计数，
    // 因此在闭包执行时，如果self已经被释放了，那么该闭包内部对self的引用会自动被置为nil，避免了循环引用导致的内存泄漏问题
    
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
    
    private func getChannel(with channelId: String) {
        FirebaseConstants.ChannelRef.child(channelId).observe(.value) { [weak self] snapshot in
            guard let dict = snapshot.value as? [String : Any] else { return }
            var channel = ChannelItem(dict)
            self?.getChannelMembers(channel) { members in
                channel.members = members
                self?.channelDictionary[channelId] = channel
                self?.reloadData()
//                self?.channels.append(channel)
            }
        } withCancel: { error in
            print("🙅🏻 Failed to get the channel for id \(channelId) :\(error.localizedDescription)")
        }
    }
    
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


