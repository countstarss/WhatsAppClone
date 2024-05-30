//
//  BubbleTailView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct BubbleTailView: View {
    var direction: MessageDirection
    
    private var backgroundColor : Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(.template)
            .resizable()
            .frame(width: 10, height: 10)
//            .offset(x:direction == .sent ? 5 : -5,y:3)
            .offset(y:1)
            .foregroundStyle(backgroundColor)
    }
}

#Preview {
    ScrollView{
        BubbleTailView(direction: .sent)
        BubbleTailView(direction: .received)
    }
    .frame(maxWidth: .infinity)
    .background(Color.green)
}
