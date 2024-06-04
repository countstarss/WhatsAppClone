//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChatRoomScreen: View {
    let channel : ChannelItem
    
    
    
    var body: some View {
        MessageListView()
        .toolbar(.hidden, for: .tabBar)
        .toolbar{
            leadingNavItem()
            trailingNavItem()
        }
        .safeAreaInset(edge: .bottom) {
            TextInputArea()
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
