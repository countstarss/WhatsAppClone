//
//  ChatPartnerPickerViewModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation
import Firebase

enum ChannelCreationRoute{
    case groupPartnerPicker
    case setUpGroupChat
}

/// 规定Group的最大人数
enum ChannelConstants{
    static let maxGroupParticipants = 12
}

@MainActor
final class ChatPartnerPickerViewModel:ObservableObject {
    // ObservableObject可以让app更加响应式
    // 通过创建ViewModel来协调所有的功能
    @Published var navStack = [ChannelCreationRoute]()
    // 用于选中和取消
    @Published var selectedChatPartners = [UserItem]()
    // 用于保存
    @Published private(set) var users = [UserItem]()
    // 保存第一个作为指针
    private var lastCursor : String?
    
    
    // 用于显示/隐藏选中的chatPartners的视图
    var showSelectedUsers :Bool {
        // 只要不空
        return !selectedChatPartners.isEmpty
    }
    
    // 用于Enable Next按钮
    var disableNextButton:Bool {
        return selectedChatPartners.isEmpty
    }
    
    // 判断时候可分页,用于防止重复fetchUser
    var isPageinatable: Bool{
        return !users.isEmpty
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
    
    func handleItemSelection(_ item:UserItem) {
        if isUserSelected(item) {
            // 如果已经被选中了,那就取消选中 -- deselect
            // 找出已经被选中item的index,然后删除
            guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
            selectedChatPartners.remove(at: index)
        }else{
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
    
    func buildDirectChannel() async -> Result<ChannelItem,Error>{
        
    }
}
