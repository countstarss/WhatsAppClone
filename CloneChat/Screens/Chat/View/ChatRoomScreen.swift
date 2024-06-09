//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel : ChannelItem
    @StateObject private var viewModel :ChatRoomViewModel
    
    // 使用依赖注入的方式将 ChatRoomViewModel 实例注入到视图中
    init(channel: ChannelItem) {
        self.channel = channel
        // 依赖注入
        // 将viewModel传入
        _viewModel = StateObject(wrappedValue: ChatRoomViewModel(channel: channel))
    }

    // 生命周期：@StateObject状态由SwiftUI管理，确保对象的生命周期与视图的生命周期保持一致。当视图被重新创建时（例如在视图树中被移动或被删除再添加）
    // @StateObject: 会重新创建对象实例。
    // 使用场景：适用于需要在多个视图之间共享的状态或者复杂的对象状态。
    
    var body: some View {
        MessageListView()
        .toolbar(.hidden, for: .tabBar)
        .toolbar{
            leadingNavItem()
            trailingNavItem()
        }
        .safeAreaInset(edge: .bottom) {
            TextInputArea(textMessage: $viewModel.textMessage){
                viewModel.sendMessage()
            }
        }
    }
}

extension ChatRoomScreen{
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack{
                Circle()
                    .frame(width: 35, height: 35)
                // 本身没有定义title,如果想这样使用,
                // 就要先使用Firebase获取到当前的user,然后使用filter过滤一下members
                // 声明title,根据不同的条件返回不同的值,ChannelItem中的name是可选值,所以使用if-binding
                // 如果是group channel 返回"Group channel"
                // 如果是direct channel 返回member中的第一个的userName
                Text(channel.title)
                    .bold()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button(action: {
                
            }, label: {
                Image(systemName: "video")
            })
            
            Button(action: {
                
            }, label: {
                Image(systemName: "phone")
            })
        }
    }
}

#Preview {
    NavigationStack{
        ChatRoomScreen(channel: .placeholder)
    }
}
