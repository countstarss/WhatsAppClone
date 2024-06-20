//
//  ChannelTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText:String = ""
    @StateObject private var viewModel = ChannelTabViewModel()
    var body: some View {
        NavigationStack(path: $viewModel.navRoutes){
            List{
                archivedButton()
                    .padding(.horizontal)
                
                // 把原来的NavigationLink修改为使用自定义的Routes控制
                ForEach(viewModel.channels){channel in
                    Button{
                        viewModel.navRoutes.append(.chatRoom(channel))
                    }label: {
                        ChannelItemView(channel: channel)
                    }
                    // 写到这里，还需要添加导航的目的地

                }
                inboxFooterView()
                    .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar{
                leadingNavItem()
                trailingNavItem()
            }
            // 需要两个参数，第一个
            .navigationDestination(for: ChannelTabRoutes.self){ route in
                // 用来为Button导航
                destinationView(for: route)
            }
            .sheet(isPresented: $viewModel.showChatPartnerPickerScreen){
                ChatPartnerPickerScreen(
                    showChatPartnerPickerScreen: $viewModel.showChatPartnerPickerScreen,
                    // 实现点击ChatPartnerRowView关闭NavigationView
                    onCreate: viewModel.onNewChannelCreation
                )
                    
            }
            // 导航到新的ChatRom
//            .navigationDestination(isPresented: $viewModel.navigateToChatRoom) {
//                if let newChannel = viewModel.newChannel{
//                    ChatRoomScreen(channel: newChannel)
//                }
//            }
            .refreshable {
//                viewModel.channels.removeAll()
                viewModel.fetchCurrentUserChannels()
            }
        }
    }
}


//MARK: - Toolbar Buttons
extension ChannelTabScreen{
    
    @ViewBuilder
    private func destinationView(for route :ChannelTabRoutes) -> some View {
        switch route {
        // 导航到各自channel对应的ChatRoomScreen ，他们都依赖channel
        case .chatRoom(let channel):
            ChatRoomScreen(channel: channel)
        }
    }
    
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button{
                    
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }

        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent{
        ToolbarItemGroup(placement: .topBarTrailing) {
            AiButton()
            caremaButton()
            newChatButton()
        }
    }
    
    
    private func AiButton() -> some View{
        Button{
            
        } label: {
            Image(.circle)
        }
    }
    
    private func caremaButton() -> some View{
        Button{
            
        } label: {
            Image(systemName: "camera")
        }
    }
    
    private func newChatButton() -> some View{
        Button{
            // 使用变量控制显示，不是导航
            viewModel.showChatPartnerPickerScreen = true
        } label: {
            Image(.plus)
        }
    }
    
    private func archivedButton() -> some View{
        Button{
            
        } label: {
            Label("Archived", systemImage: "archivebox.fill")
                .bold()
                .padding(.vertical,10)
                .foregroundStyle(.gray)
        }
    }
    
    private func inboxFooterView() -> some View {
        HStack{
            Image(systemName: "lock.fill")

                Text("Your personal message are ")
                +
                Text("end-to-end encrypted")
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
            
        }
        .foregroundStyle(.gray)
        .font(.caption)
        .padding(.horizontal)
    }
}



#Preview {
    ChannelTabScreen()
}
