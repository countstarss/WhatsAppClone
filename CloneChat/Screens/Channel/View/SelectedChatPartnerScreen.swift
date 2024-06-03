//
//  SelectedChatPartnerView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/6/1.
//

import SwiftUI

struct SelectedChatPartnerView: View {
    let users:[UserItem]
    let onTapHandler: (_ user: UserItem) -> Void
    @StateObject private var viewModel = ChatPartnerPickerViewModel()
    
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                // 这里传入user 用来替换UserItem.placeholders 是一个关键,user是一个在这里定义的[UserItem]
                // 页面实际使用的是调用时传入的
                ForEach(users){item in
                    chatPartnerView(item)
                }
            }
        }
    }
    
    private func chatPartnerView(_ user: UserItem) -> some View {
        VStack{
            Circle()
                .fill(.indigo)
                .frame(width: 60, height: 60)
                .overlay(alignment:.topTrailing){
                    cancelButton(user)
                }
            
            Text(user.username)
        }
    }
    
    private func cancelButton(_ user: UserItem) -> some View{
        Button {
            onTapHandler(user)
        } label: {
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(5)
                .background(Color(.systemGray2))
                .clipShape(Circle())
        }

    }
}

#Preview {
    SelectedChatPartnerView(users: UserItem.placeholders){ user in
        
    }
}
