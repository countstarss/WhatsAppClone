//
//  NewGroupSetUpScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/6/1.
//

import SwiftUI

struct NewGroupSetUpScreen: View {
    @State private var channelName = ""
    @ObservedObject var viewModel = ChatPartnerPickerViewModel()
    
    var body: some View {
            List{
                Section{
                    channelSetUpHeaderView()
                }
                Section {
                    Text("Disappearing Message")
                    Text("Group Permissions")
                }
                
                Section {
                    SelectedChatPartnerView(users: viewModel.selectedChatPartners){ user in
                        viewModel.handleItemSelection(user)
                    }
                }header: {
                    let count = viewModel.selectedChatPartners.count
                    Text("Partticipants : \(count)")
                        .bold()
                        
                }
                .listRowBackground(Color.clear)
                .navigationTitle("New Group")
                
                
            }
            .toolbar{
                trailingNavItem()
            }
    }
    
    private func channelSetUpHeaderView() -> some View {
        HStack{
            Circle()
                .frame(width: 60, height: 60)
            
            TextField(
                "",
                text: $channelName,
                prompt: Text("Group Name (optional)"),
                axis: .vertical
            )
        }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent{
        ToolbarItem(placement:.topBarTrailing){
            Button{
                
            }label: {
                Text("Create")
                    .bold()
            }
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NewGroupSetUpScreen(viewModel: ChatPartnerPickerViewModel())
}
