//
//  ChatPartnerPickerViewModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation
import Firebase

//MARK: - Navigation Route
// 用于导航。一般来说有几层就有几个case
enum ChannelCreationRoute{
    case groupPartnerPicker
    case setUpGroupChat
}

/// 规定Group的最大人数
enum ChannelConstants{
    static let maxGroupParticipants = 12
}

enum ChannelCreationError :Error {
    case noChatPartner
    case failedToCreateIds
}

@MainActor
final class ChatPartnerPickerViewModel:ObservableObject {
    // ObservableObject可以让app更加响应式
    // 通过创建ViewModel来协调所有的功能
    
    //MARK: - 导航的栈
    @Published var navStack = [ChannelCreationRoute]()
    // 用于选中和取消
    @Published var selectedChatPartners = [UserItem]()
    // 用于保存
    @Published private(set) var users = [UserItem]()
    // Error
    @Published var errorState: (showError :Bool , errorMessage :String) = (false,"Uh Oh")
    // 保存第一个作为指针
    private var lastCursor : String?
    
    
    // 用于显示/隐藏选中的chatPartners的视图
    var showSelectedUsers :Bool {
        // 只要不空
        return !selectedChatPartners.isEmpty
    }
    
    // 用于Enable Next按钮
    var disableNextButton:Bool {
        return selectedChatPartners.count < 2
    }
    
    // 判断时候可分页,用于防止重复fetchUser
    var isPageinatable: Bool{
        return !users.isEmpty
    }
    
    // 判断是否Direct Channel
    private var isDirectChannel :Bool {
        return selectedChatPartners.count == 1
    }
    
    init(){
        Task{
            print("FetchUsers")
            await fetchUsers()
        }
    }
    
    //MARK: - Public Methods
    
    func fetchUsers() async {
        do{
            // 在获取数据的时候,过滤掉当前的用户
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 10)
            var fetchUsers = userNode.users
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            fetchUsers = fetchUsers.filter { $0.uid != currentUid}
            self.users.append(contentsOf: fetchUsers)
            self.lastCursor = userNode.currentCursor
        }catch{
            print("💿 Failed to fetch user in ChatPartnerPickerViewModel : \(error.localizedDescription)")
        }
    }
    
    func deSelectAllChatPartners() {
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.selectedChatPartners.removeAll()
        }
    }
    
    func handleItemSelection(_ item:UserItem) {
        if isUserSelected(item) {
            // 如果已经被选中了,那就取消选中 -- deselect
            // 找出已经被选中item的index,然后删除
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        }else{
            guard selectedChatPartners.count < ChannelConstants.maxGroupParticipants else {
                let errorMessage = "Sorry ,we only allow maxumum of \(ChannelConstants.maxGroupParticipants) particapants in a group chat"
                showError(errorMessage)
                return
            }
            // 如果没有被选中,那就选择
            // selectedChatPartners是一个被选中的UserItem数组
            selectedChatPartners.append(item)
        }
    }
    
    // 通过contains判断是否已经选中
    func isUserSelected(_ user: UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains {$0.uid == user.uid}
        return isSelected
    }
    
    // 重新创建一个用于创建direction function,将通用方法设为private,只能在viewModel中调用
    func createDirectChannel(chatPartner : UserItem,completion:@escaping (_ newChannel: ChannelItem) -> Void){
        // 下面是很关键的一步,把选中user添加到selectedChatPartners中
        selectedChatPartners.append(chatPartner)
        
        Task{
            if let channelId = await vertifyIfDirectChannelExists(with: chatPartner.uid){
                // 如果已经存在,get the channel
                let snapshot = try await FirebaseConstants.ChannelRef.child(channelId).getData()
                let channelDict = snapshot.value as! [String : Any]
                var directChannel = ChannelItem(channelDict)
                directChannel.members = selectedChatPartners
                // completion是在程序执行完之后执行的程序
                completion(directChannel)
            }else{
                // create a new directMessage tith the user
                let channerCreation = createChannel(nil)
                switch channerCreation{
                case .success(let channel):
                    completion(channel)
                case .failure(let failure):
                    showError("Sorry, something wrong when creating a direct channel")
                    print("💿 Failure to create a direct channel\(failure.localizedDescription)")
                }
            }
        }
    }
    
    // 验证是否已经存在此会话,如果存在,那么就不创建channel,而是导航到已经创建的chat
    // 实际上realtime Database 不会重复生成,我们需要判断出来然后导航到目标Screen
    typealias ChannelId = String
    private func vertifyIfDirectChannelExists(with chatPartnerId :String ) async -> ChannelId? {
        print("Vertify")
        guard let currentUid = Auth.auth().currentUser?.uid,
              let snapshot = try? await FirebaseConstants.UserDirectChannels.child(currentUid).child(chatPartnerId).getData(),
              snapshot.exists()
        else { return nil }
        
        let directMessageDict = snapshot.value as! [String : Bool]
        let channelId = directMessageDict.compactMap{ $0.key }.first
        print("🥳DEBUG: channelId is \(String(describing: channelId))")
        return channelId
    }
    
    
    func createGroupChannel(_ groupName:String?,completion:@escaping (_ newChannel: ChannelItem) -> Void){
        let channerCreation = createChannel(groupName)
        switch channerCreation{
        case .success(let channel):
            completion(channel)
        case .failure(let failure):
            showError("Sorry, something wrong when creating a group channel")
            print("💿 Failure to create a group channel\(failure.localizedDescription)")
        }
    }
    
    //MARK: - Private Function
    private func showError(_ errorMessage: String) {
        errorState.errorMessage = errorMessage
        errorState.showError = true
    }
    
    //MARK: - CreateChannel common method
    // 这是一个创建Chat的通用方法
    private func createChannel(_ channelName:String?) -> Result<ChannelItem,Error>{
        // 为了适配创建Group,所以selectedChatPartners不为空时才能createChannel
        //
        guard !selectedChatPartners.isEmpty else { return .failure(ChannelCreationError.noChatPartner) }
        
        guard let channelId = FirebaseConstants.ChannelRef.childByAutoId().key,
              let currentUid = Auth.auth().currentUser?.uid,
              let messageId = FirebaseConstants.MessageRef.childByAutoId().key
        else{ return .failure(ChannelCreationError.failedToCreateIds) }
        
        
        let timeStmp = Date().timeIntervalSince1970
        // 建立群组的时候把自己也加进去
        var membersUids = selectedChatPartners.compactMap{ $0.uid }
        membersUids.append(currentUid)
        
        
        let newChannelBroadcase = AdminMessageType.channelCreation.rawValue
        
        // channelDict是要存储到数据库的channel信息
        var channelDict :[String :Any] = [
            .id: channelId,
            .lastMessage: newChannelBroadcase,
            .creationDate: timeStmp,
            .lastMessageTimeStmp: timeStmp,
            .membersUids: membersUids,
            .membersCount: membersUids.count,
            .adminUids: [currentUid],
            .createdBy: currentUid
                
        ]
        
//        if let channelname = ((channelName?.isEmptyorWhiteSpace) != nil) ? channelName : nil {
//            print("channelname is vaild : \(channelname)")
//            channelDict[.name] = channelname
//        }
        if let channelname = channelName{
            print("channelname is vaild : \(channelname)")
            channelDict[.name] = channelname
        }
        
        // 创建messageDict,(消息存储的结构)
        let messageDict :[String : Any] = [
            // 字符串改用静态类型  (在model中创建String的extension)
            .type : newChannelBroadcase,
            .timeStmp : timeStmp,
            .ownerUid : currentUid
        ]
        
        // ------ 需要存储的东西 ------
        // channel - 存储channelDict
        // 只有一层结构,每新建一个对话,就存储一个channel
        FirebaseConstants.ChannelRef.child(channelId).setValue(channelDict)
        // 两层结构,message文件夹里,每个Channel有一个message文件夹,里边包含所有人的message记录
        FirebaseConstants.MessageRef.child(channelId).child(messageId).setValue(messageDict)
        
        // userChannel
        // 两层结构,外层userId,内层channelId
        // 数量上限是user的上限,内层是每个user打开对话的数量
        membersUids.forEach{ userId in
            // keeping an index of the channel that a specific user belongs to
            FirebaseConstants.UserChannelRef.child(userId).child(channelId).setValue(true)
        }
        
        // 存储用户所属的direct channel
        if isDirectChannel{
            let chatPartner = selectedChatPartners[0]
            // 两层结构,外层currentUid,内层chatPartner.uid,赋值是两用户共同拥有的channelId
            // 总数量是所有用户拥有对话的和,相当于是笛卡尔积,我对三个人发起了会话,这是三条,对方也分别拥有和我的会话,一共6条记录
            FirebaseConstants.UserDirectChannels.child(currentUid).child(chatPartner.uid).setValue([channelId : true])
            FirebaseConstants.UserDirectChannels.child(chatPartner.uid).child(currentUid).setValue([channelId : true])
        }
        
        var newChannelItem = ChannelItem(channelDict)
        newChannelItem.members = selectedChatPartners
        return .success(newChannelItem)
        
    }
}
