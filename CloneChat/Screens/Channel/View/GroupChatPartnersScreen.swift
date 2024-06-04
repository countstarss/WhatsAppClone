//
//  AddGroupChatPartnersScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import SwiftUI

struct GroupChatPartnersScreen: View {
    @ObservedObject var viewModel :ChatPartnerPickerViewModel
    
    @State private var searchText = ""
    var body: some View {
        List{
            // 这里的判断条件是只要不是空的就显示
            if viewModel.showSelectedUsers {
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { user in
                    viewModel.handleItemSelection(user)
                        
                }
                .onTapGesture {
                    print("Tap")
                }
            }
            
            Section{
                ForEach(viewModel.users){item in
                    // 使具有选中功能
                    Button{
                        viewModel.handleItemSelection(item)
                        print("Item Button is Pressed")
                    }label: {
                        chatPartnerRowView(item)
                    }
                }
            }
            if viewModel.isPageinatable{
                loadMoreUsers()
            }
            
        }
        .animation(.easeOut, value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always))
        .toolbar{
            titleView()
            traillingNavItem()
        }
    }
    
    private func chatPartnerRowView(_ user:UserItem) -> some View {
        ChatPartnerRowView(user: user){
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            Image(systemName: imageName)
                .foregroundStyle(Color(isSelected ? .systemBlue : .systemGray4  ))
                .imageScale(.large)
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




extension GroupChatPartnersScreen {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent{
        ToolbarItem(placement:.principal){
            VStack{
                Text("Add Participants")
                    .bold()
                // 选中人数
                let count = viewModel.selectedChatPartners.count
                // 人数基数
//                let maxCount = 12
//                let maxCount = ChannelConstants.maxGroupParticipants
                let maxCount = viewModel.users.count
                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
//            .frame(height: 40)
        }
    }
    
    @ToolbarContentBuilder
    private func traillingNavItem() -> some ToolbarContent{
        ToolbarItem(placement:.topBarTrailing){
            VStack{
                Button("Next"){
                    print("Button Next is Pressed")
                    viewModel.navStack.append(.setUpGroupChat)
                }
                .disabled(viewModel.disableNextButton)
            }
//            NavigationLink("Next") {
//                NewGroupSetUpScreen(viewModel: viewModel)
//            }
//            .disabled(viewModel.disableNextButton)
        }
    }
}
#Preview {
    NavigationStack{
        GroupChatPartnersScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
