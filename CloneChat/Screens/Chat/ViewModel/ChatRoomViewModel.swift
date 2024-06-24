//
//  ChatRoomViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/7.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

// `final` 关键字用于防止类被继承或者防止类的方法、属性被重写
final class ChatRoomViewModel:ObservableObject{
    
    @Published var textMessage = ""
    
    // 在MessageSevercve中创建的messages只是一个临时的，我们需要在这里创建messages来保存
    @Published var messages : [MessageItem] = [MessageItem]()
    
    // private(set) var 让外部也能访问到channel
    private(set) var channel:ChannelItem
    
    // 用于打开PhotoPicker
    @Published var showPhotoPicker = false
    @Published var photoPickerItems : [PhotosPickerItem] = []
    
    @Published var selectedPhotos:[UIImage] = []
    
    // 用于控制显示MediaAttachmentPreview
    var showPhotoPickerPreview: Bool {
        return !photoPickerItems.isEmpty
    }
    
    // AnyCancellable <关键点>
    // Set<AnyCancellable>：在视图模型中，我们通常使用一个集合来存储 AnyCancellable 实例，以便在视图模型的生命周期内保持订阅有效。
    // store(in:)：通过调用 store(in:) 方法，可以将 AnyCancellable 实例存储在一个集合中，这样在需要时可以统一管理这些订阅。
    private var subScriptions = Set<AnyCancellable>()
    
    private var currentUser :UserItem?
    
    init(channel: ChannelItem) {
        self.channel = channel
        // listenToAuthState初始化currentUser
        listenToAuthState()
        // 加到init中执行，以监控selectedPhotos的变化
        onPhotoPickerSelection()
    }
    
    private func listenToAuthState() {
        AuthManager.shared.authState.receive(on: DispatchQueue.main).sink{ [weak self] authState in
            guard let self = self else { return }
            switch authState{
                // 如果通过Firebase Auth拿到当前的登陆状态是LogedIn
            case .loggedIn(let current):
                self.currentUser = current
                // 如果不需要fetch，直接调用getMessage()
                
                // 导致无法正确判断allMembersFetched是否为true的原因是：
                    // 在ChannelTabViewModel中获取Channel时，没有把当前user添加进去,导致channel只有一个
                if self.channel.allMembersFetched{
                    print("allMembersFetched: \(channel.members.map { $0.username })")
                    self.getMessage()
                }else {
                    print("in else")
                    // 改变顺序，先获取所有的channelMembers，然后在fetchAllChannelMembers函数里getMessage
                    self.fetchAllChannelMembers()
                }
            default :
                break
            }
            //
        }.store(in: &subScriptions)
    }
    
    func sendMessage() {
        MessageSeverce.sendTextMessage(to: channel, from: currentUser ?? .placeholder, textMessage) { [weak self] in
            self?.textMessage = ""
        }
        getMessage()
    }
    
    private func getMessage(){
        // 这里闭包中的messages是 MessageSeverce.getMessages 的completion传过来的
        MessageSeverce.getMessages(for:channel) {[weak self] messages in
            self?.messages = messages // 把channel对应的messages赋值给模板messages
            print("messages: \(messages.map{ $0.text })")
        }
    }
    
    // 只有是Group channel时，才会调用这个函数
    private func fetchAllChannelMembers() {
        // 现在已经有了currnetUser和前两个用户，只需要获取其他user
        guard let currentUser = currentUser else { return }
        let membersAlreadyFetched = channel.members.compactMap { $0.uid } // 得到的是一个uid数组
        // 需要获取的是membersUids中不包含membersAlreadyFetched中的部分
        var membersUidsToFetch = channel.membersUids.filter { !membersAlreadyFetched.contains($0) } // 去掉已获取
        membersUidsToFetch = membersUidsToFetch.filter{ $0 != currentUser.uid } // 去掉currentUser
        
        UserService.getUser(with: membersUidsToFetch) { [weak self] userNode in
            guard let self = self else { return }
            self.channel.members.append(contentsOf: userNode.users)
//            self.channel.members.append(currentUser) // 把currentUser添加到最后面
            print("fetchAllChannelMembers: \(channel.members.map {$0.username})")
        }
        getMessage()
    }
    
    // 根据点击的按钮选择不同的方法，这个方法是TextInput的actionHandle
    func handleTextInputArea(_ action:TextInputArea.userAction) {
        switch action {
        case .presentPhotoPicker:
            showPhotoPicker = true
            print("showPhotoPicker:\(showPhotoPicker)")
        case .sendMessage:
            sendMessage()
        }
    }
    
    
    
    // 添加照片的思路分析： 
    // 1. 监控$photoPickerItems，当其中有内容时，将PhotosPicker得到的整个数组拿去解码
    // 2. 把数组中的item循环取出，将其转换成可传输的对象，然后将得到的数据转成UIImage类型
    // 3. 把得到的图片插入到selectedPhotots中，每次都插入到最前面
    
    private func onPhotoPickerSelection() {
        $photoPickerItems.sink { [weak self] photoItems in
            guard let self = self else { return }
            Task{
                await self.parsePhotoPickerItem(photoItems)
            }
        }.store(in: &subScriptions)
        // store的作用 ：管理订阅生命周期
        // 确保Combine的订阅在subScriptions集合中保存,这意味着只要subScriptions存在，订阅就会保持活动状态。
    }
    
    private func parsePhotoPickerItem(_ photoPickerItems: [PhotosPickerItem]) async {
        for photoItem in photoPickerItems {
            guard
                let data = try? await photoItem.loadTransferable(type: Data.self),
                // loadTransferable，将特定数据类型中加载数据并将其转换为可传输的对象。通常用于处理和传输数据的场景，比如从照片库中加载照片、从文件中读取数据等。
                let uiImage = UIImage(data: data)
            else { return }
            self.selectedPhotos.insert(uiImage, at: 0)
        }
    }
    
}
