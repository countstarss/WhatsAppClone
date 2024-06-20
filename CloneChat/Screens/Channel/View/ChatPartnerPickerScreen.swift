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
    
    // 创建新对话:
    //    1.关闭当前页面
    //    2.进入新创建的chat
    var onCreate:(_ newChannel:ChannelItem) -> Void
    
    var body: some View {
        NavigationStack(path: $viewModel.navStack){
            List{
                ForEach(ChatPartnerPickerOption.allCases){ item in
                    HeaderItemView(item: item){
                        // 如果item不是newGroup,--自动忽略--
                        guard item == ChatPartnerPickerOption.newGroup else { return }
                        //MARK: - 第一层导航
                        viewModel.navStack.append(.groupPartnerPicker)
                    }
                }
                
                Section{
                    ForEach(viewModel.users){ user in
                        ChatPartnerRowView(user: user)
                            // 与单个用户创建聊天
                            .onTapGesture{
//                                onCreate(.placeholder)
                                // 将添加user逻辑放到函数createDirectChannel中
                                viewModel.createDirectChannel(
                                    chatPartner: user,
                                    completion: onCreate
                                )
                                //createDirectChannel 不使用导航，而是生成直接
                            }
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
            .alert(isPresented: $viewModel.errorState.showError){
                // 添加错误提醒,出发条件是viewModel.errorState.showError
                // 如果想要触发报错,那么就需要在可能发生错误的地方设置判断条件,最好用guard
                // 发生错误就将viewModel.errorState.showError改为true
                Alert(
                    title: Text("Uh Oh 🙅🏻"),
                    message: Text(viewModel.errorState.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
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
            .onAppear{
                viewModel.deSelectAllChatPartners()
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
            NewGroupSetUpScreen(viewModel: viewModel,onCreate: onCreate)
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
        let opTapHandler: () -> Void
        
        var body: some View{
            Button{
                opTapHandler()
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

// 这个是三个选项,分别通向不同的地方
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
    ChatPartnerPickerScreen(showChatPartnerPickerScreen: .constant(false)){ channel in
        // 
    }
}
