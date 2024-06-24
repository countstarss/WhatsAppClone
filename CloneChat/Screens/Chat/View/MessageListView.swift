//
//  MessageListView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageListController
    private var viewModel :ChatRoomViewModel
    
    // 注入viewModel
    init(_ viewModel: ChatRoomViewModel) {
        self.viewModel = viewModel
    }
    func makeUIViewController(context: Context) -> MessageListController {
        let messageListController = MessageListController(viewModel)
        return messageListController
    }
    
    func updateUIViewController(_ uiViewController: MessageListController, context: Context) { }
    
}

#Preview {
    MessageListView(ChatRoomViewModel(channel: .placeholder))
}
