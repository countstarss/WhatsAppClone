//
//  ChatPartnerPickerScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    @State private var searchText = ""
    @Binding var showChatPartnerPickerScreen : Bool
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ChatPartnerPickerViewModel()
    var body: some View {
        NavigationStack(path: $viewModel.navStack){
            List{
                ForEach(ChatPartnerPickerOption.allCases){ item in
                    HeaderItemView(item: item)
                        .onTapGesture {
                            viewModel.navStack.append(.groupPartnerPicker)
                        }
                }
                
                Section{
                    ForEach(viewModel.users){ user in
                        ChatPartnerRowView(user: user)
                            // 与单个用户创建聊天
                    }
                }header: {
                    Text("Contact on Whatsapp")
                        .textCase(nil)
                        .bold()
                }
                
                if viewModel.isPageinatable{
                    loadMoreUsers()
                }
                
            }
            .navigationTitle("New Chat")
            .navigationDestination(for: ChannelCreationRoute.self){ route in
                DestinationRoute(for: route)
                    .onTapGesture {
                        
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(
                    displayMode: .always
                ),
                prompt: "Search name or number"
            )
            .toolbar{
                trailingNavItem()
            }
        }
        
    }
    private func loadMoreUsers() -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .task {
                await viewModel.fetchUsers()
            }
    }
}

extension ChatPartnerPickerScreen{
    
    // 使其成为ViewBUilder
    @ViewBuilder
    private func DestinationRoute(for route: ChannelCreationRoute) -> some View {
        switch route {
        case .groupPartnerPicker:
            GroupChatPartnersScreen(viewModel: viewModel)
        case .setUpGroupChat:
            NewGroupSetUpScreen(viewModel: viewModel)
//            Text("SET UP GROUP CHAT")
        }
        
    }
}


extension ChatPartnerPickerScreen{
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement:.topBarTrailing) {
            CancelButton()
        }
    }
    private func CancelButton() -> some View {
        Button {
            showChatPartnerPickerScreen = false
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding(5)
                .background(Color(.systemGray5))
                .clipShape(Circle())
            
        }

    }
    
}
extension ChatPartnerPickerScreen{
    private struct HeaderItemView : View {
        
        let item : ChatPartnerPickerOption
        
        var body: some View{
            Button{
                
            }label: {
                ButtonBody()
            }
        }
        
        private func ButtonBody() -> some View {
            HStack{
                Image(systemName: item.imageName)
                    .font(.footnote)
                    .frame(width: 40,height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                Text(item.title)
            }
        }
        
    }
}

enum ChatPartnerPickerOption: String,CaseIterable,Identifiable{
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newCommunity = "New Community"
    
    
    var id :String{
        // rawValue是返回本身的值,可以省去写title和id
        return rawValue
    }
    
    var title :String{
        return rawValue
    }
    
    var imageName :String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.badge.plus.fill"
        case .newCommunity:
            return "person.3.fill"
        }
    }
}

#Preview {
    ChatPartnerPickerScreen(showChatPartnerPickerScreen: .constant(false))
}
