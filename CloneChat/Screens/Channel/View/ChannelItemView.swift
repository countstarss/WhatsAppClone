//
//  ChannelItemView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct ChannelItemView: View {
    let channel:ChannelItem
    var body: some View {
        HStack{
            CircularProfileImageView(size: .small)
                .frame(width: 60,height: 60)
                
            VStack(alignment:.leading,spacing:4){
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    private func titleTextView() -> some View {
        HStack{
            Text(channel.title)
                .bold()

            Spacer()
            
            Text("5:50 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 15))
        }
    }
    
    private func lastMessagePreview() -> some View{
        Text(channel.lastMessage)
            .font(.system(size: 16))
            .lineLimit(1)
            .foregroundStyle(.gray)
    }
}

#Preview {
    ChannelItemView(channel: .placeholder)
}
