//
//  ChannelCreationTextView.swift
//  CloneChat
//
//  Created by luke on 2024/6/19.
//

import SwiftUI

struct ChannelCreationTextView: View {
    // 添加根据颜色模式变色的功能
    @Environment(\.colorScheme) private var colorScheme
    
    private var backgroundColor:Color {
        return colorScheme == .dark ? Color.yellow.opacity(0.7) : Color(.systemGray6)
    }
    
    var body: some View {
        (
            Text(Image(systemName: "lock.fill"))
            +
            Text("Messages and calls are end-to-end encrypted,No one can outside of this chat,not even chatsapp,can read or listen to them ")
            +
            Text("Learn more")
                .bold()
        )
        .font(.footnote)
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal,30)
    }
}

#Preview {
    ChannelCreationTextView()
}
