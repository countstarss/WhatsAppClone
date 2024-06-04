//
//  ChannelTabViewModel.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation

// 使用final 将其设置为静态类
final class ChannelTabViewModel: ObservableObject {
    
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerScreen = false
    
    func onNewChannelCreation(_ channel:ChannelItem) {
        showChatPartnerPickerScreen = false
        newChannel = channel
        navigateToChatRoom = true
    }
}


