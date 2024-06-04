//
//  ChatPartnerPickerViewModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation


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
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 10)
            self.users.append(contentsOf: userNode.users)
            self.lastCursor = userNode.currentCursor
            print("💿DEBUG:\(lastCursor) --- userCount :\(users.count)")
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
}
