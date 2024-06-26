//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI
import PhotosUI


struct ChatRoomScreen: View {
    let channel : ChannelItem
    @StateObject private var viewModel : ChatRoomViewModel
    
    //MARK: - 依赖注入
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
    @MainActor
    var body: some View {
            MessageListView(viewModel)
                .frame(maxHeight: .infinity)
//                .offset(y:-60)
                .toolbar(.hidden, for: .tabBar)
                .toolbar{
                    leadingNavItem()
                    trailingNavItem()
                }
                .photosPicker(isPresented: $viewModel.showPhotoPicker,
                              selection: $viewModel.photoPickerItems,
                              maxSelectionCount: 6,
                              photoLibrary: .shared()
                )
                .navigationBarTitleDisplayMode(.inline)
//                .ignoresSafeArea(edges: .bottom) // 可以隐藏previre的白边
                .safeAreaInset(edge:.bottom) {
                    bottomSafeAreaView()
                }
                .animation(.easeInOut,value: viewModel.showPhotoPickerPreview)
                .fullScreenCover(isPresented: $viewModel.videoPlayerState.show){
                    if let player = viewModel.videoPlayerState.player{
                        mediaPlayerView(player: player) {
                            viewModel.dismissMediaPlayer()
                        }
                    }
                }
            
    }
    
    private func bottomSafeAreaView() -> some View {
        VStack(spacing:0){
            
            Divider().opacity(viewModel.showPhotoPickerPreview ? 1 : 0)
            
            if viewModel.showPhotoPickerPreview {

                MediaAttachmentPreview(mediaAttachments: viewModel.mediaAttachments){
                    action in
                    viewModel.handleMediaAttachmentPreview(action)
                }
            }
            
            Divider().opacity(viewModel.showPhotoPickerPreview ? 1 : 0)
            TextInputArea(textMessage: $viewModel.textMessage){action in
                viewModel.handleTextInputArea(action)
            }
        }
    }
    
    
    
}

extension ChatRoomScreen{
    
    //MARK: - 重写title，防止trailingNavItem() 被压缩导致UI错乱
    private var channelTitle : String {
        let maxChar = 20
        let trailingChars = channel.title.count > maxChar ? "..." : ""
        let title = String(channel.title.prefix(maxChar) + trailingChars)
        return title
    }
    
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack{
                CircularProfileImageView(size: .mini)
                    .frame(width: 35, height: 35)
                // 本身没有定义title,如果想这样使用,
                // 就要先使用Firebase获取到当前的user,然后使用filter过滤一下members
                // 声明title,根据不同的条件返回不同的值,ChannelItem中的name是可选值,所以使用if-binding
                // 如果是group channel 返回"Group channel"
                // 如果是direct channel 返回member中的第一个的userName
                Text(channelTitle)
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
