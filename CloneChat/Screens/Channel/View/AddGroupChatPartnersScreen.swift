//
//  AddGroupChatPartnersScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import SwiftUI

struct AddGroupChatPartnersScreen: View {
    @ObservedObject var viewModel :ChatPartnerPickerViewModel
    
    @State private var searchText = ""
    var body: some View {
        List{
            // 这里的判断条件是只要不是空的就显示
            if viewModel.showSelectedUsers {
                Text("User Selected")
            }
            
            Section{
                ForEach([UserItem.placeholder]){item in
                    // 使具有选中功能
                    Button{
                        viewModel.handleItemSelection(item)
                    }label: {
                        chatPartnerRowView(.placeholder)
                    }
                }
            }
        }
        .animation(.easeOut, value: viewModel.showSelectedUsers)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always))
        .toolbar{
            
        }
    }
    
    private func chatPartnerRowView(_ user:UserItem) -> some View {
        ChatPartnerRowView(user: .placeholder){
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            Image(systemName: imageName)
                .foregroundStyle(Color(isSelected ? .systemBlue : .systemGray4  ))
                .imageScale(.large)
        }
    }
}

#Preview {
    NavigationStack{
        AddGroupChatPartnersScreen(viewModel: ChatPartnerPickerViewModel())
    }
}
