//
//  AdminMessageTextView.swift
//  CloneChat
//
//  Created by luke on 2024/6/19.
//

import SwiftUI

struct AdminMessageTextView: View {
    let channel :ChannelItem
    
    var body: some View {
        VStack{
            // 要用到一个新的isCreatedByMe属性，就去ChannelItem里面创建
            if channel.isCreatedByMe {
                textView("You created this group , Tap to invite \n more people")
            }else {
                textView("\(channel.creatorName) created this channel")
                textView("\(channel.creatorName) added you")
            }
        }
 
    }
    
    private func textView(_ text:String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.footnote)
            .padding(10)
            .padding(.horizontal,5)
            .background(.bubbleWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color(.systemGray4).opacity(0.1), radius: 5, x: 2, y: 20)
    }
    
    
}

#Preview {
    ZStack{
        Color.gray.opacity(0.2)
        
        AdminMessageTextView(channel: .placeholder)
    }
    .ignoresSafeArea()
}
