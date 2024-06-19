//
//  ChatRoomViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/7.
//

import Foundation
import Combine

// `final` 关键字用于防止类被继承或者防止类的方法、属性被重写
final class ChatRoomViewModel:ObservableObject{
    @Published var textMessage = ""
    // 在MessageSevercve中创建的messages只是一个临时的，我们需要在这里创建messages来保存
    @Published var messages : [MessageItem] = [MessageItem]()
    // private(set) var 让外部也能访问到channel
    private(set) var channel:ChannelItem
    
    // AnyCancellable <关键点>
    // Set<AnyCancellable>：在视图模型中，我们通常使用一个集合来存储 AnyCancellable 实例，以便在视图模型的生命周期内保持订阅有效。
    // store(in:)：通过调用 store(in:) 方法，可以将 AnyCancellable 实例存储在一个集合中，这样在需要时可以统一管理这些订阅。
    private var subScriptions = Set<AnyCancellable>()
    
    private var currentUser :UserItem?
    
    init(channel: ChannelItem) {
        self.channel = channel
        // listenToAuthState初始化currentUser
        listenToAuthState()
    }
    
    private func listenToAuthState() {
        AuthManager.shared.authState.receive(on: DispatchQueue.main).sink{ [weak self] authState in
            switch authState{
                // 如果通过Firebase Auth拿到当前的登陆状态是LogedIn
            case .loggedIn(let current):
                self?.currentUser = current
                self?.getMessage()
            default :
                break
            }
            //
        }.store(in: &subScriptions)
    }
    
    func sendMessage() {
        MessageSeverce.sendTextMessage(to: channel, from: currentUser ?? .placeholder, textMessage) { [weak self] in
            self?.textMessage = ""
//            print("MessageService is sending")
        }
        print("MessageService is sending")
        getMessage()
    }
    
    private func getMessage(){
        // 这里闭包中的messages是 MessageSeverce.getMessages 的completion传过来的
        MessageSeverce.getMessages(for:channel) {[weak self] messages in
            self?.messages = messages
            print("messages: \(messages.map{ $0.text })")
        }
    }
}
