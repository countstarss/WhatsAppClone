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
            // 这里一定别忘了传递channel
            CircularProfileImageView(channel,size: .small)
                .frame(width: 60,height: 60)
                
            VStack(alignment:.leading,spacing:4){
                titleTextView()
                lastMessagePreview()
            }
        }
    }
    
    //MARK: - 重写title，防止trailingNavItem() 被压缩导致UI错乱
    private var channelTitle : String {
        let maxChar = 25
        let trailingChars = channel.title.count > maxChar ? "..." : ""
        let title = String(channel.title.prefix(maxChar) + trailingChars)
        return title
    }
    
    private func titleTextView() -> some View {
        HStack{
            Text(channelTitle)
                .bold()
                .lineLimit(1)

            Spacer()
            
            Text(channel.lastMessageTimeStmp.dayOrTimeRepresentation)
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
