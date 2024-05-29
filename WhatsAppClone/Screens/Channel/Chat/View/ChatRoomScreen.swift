//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChatRoomScreen: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0..<10){_ in
                    Text("PleacHolder")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(Color(.systemGray5))
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar{
            leadingNavItem()
            trailingNavItem()
        }
        .safeAreaInset(edge: .bottom) {
            TextInputArea()
        }
    }
}

extension ChatRoomScreen{
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack{
                Circle()
                    .frame(width: 35, height: 35)
                
                Text("Quser 12")
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
        ChatRoomScreen()
    }
}
