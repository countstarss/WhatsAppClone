//
//  ChannelTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText:String = ""
    var body: some View {
        NavigationStack{
            List{
                archivedButton()
                    .padding(.horizontal)
                
                ForEach(0..<5){_ in
                    NavigationLink{
                        ChatRoomScreen()
                    }label:{
                        ChannelItemView()
                    }
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
        }
    }
}


//MARK: - Toolbar Buttons
extension ChannelTabScreen{
    
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
