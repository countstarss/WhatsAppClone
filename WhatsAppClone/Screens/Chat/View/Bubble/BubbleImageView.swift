//
//  BubbleImageView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct BubbleImageView: View {
    let item : MessageItem
    
    var body: some View {
        HStack{
            if item.direction == .sent { Spacer() }
            HStack{
                if item.direction == .sent { shareButton() }
                
                messageTextView()
                    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 10, x: 0, y: 20)
                    .padding(.vertical)
                    .overlay(alignment:.bottomTrailing){
                        timeStmpTextView()
                            .offset(x:-10,y:5)
                    }
                    .overlay {
                        playButton()
                            .opacity(item.type == .video ? 1 : 0)
                            .offset(y:-15)
                    }

                if item.direction == .received { shareButton() }
            }
            if item.direction == .received { Spacer() }
        }
        
    }
    
    private func messageTextView() -> some View {
        VStack(alignment:.leading,spacing:5){
            Image(.stubImage0)
                .resizable()
                .scaledToFill()
                .frame(width: 220,height: 180)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style:.continuous
                    )
                )
                .background(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style:.continuous)
                    .fill(Color(.systemGray4))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20,style:.continuous)
                        .stroke(Color(.systemGray3))
                )
                
            Text(item.text)
                .padding([.horizontal,.bottom],8)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(width: 220)
//            timeStmpTextView()
        }
        
        .background(item.direction == .sent ? .bubbleGreen : .bubbleWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .applyTail(item.direction)
    }
    
    private func shareButton() -> some View {
        Button{
            
        }label: {
            Image(systemName: "arrowshape.turn.up.right.fill")
                .padding(10)
                .foregroundStyle(.whatsAppWhite)
                .background(.thinMaterial)
                .background(Color.gray)
                .clipShape(Circle())
        }
    }
    
    private func playButton() -> some View {
        Button{
            
        }label: {
            Image(systemName: "play.fill")
                .padding()
                .imageScale(.large)
                .foregroundColor(.gray)
                .background(.thinMaterial)
                .clipShape(Circle())
        }
    }
    
    private func timeStmpTextView() -> some View {
        HStack{
            Text("13:41 AM")
                .font(.system(size: 13))
                .foregroundStyle(.gray)
            
            if item.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
        }
    }
}


#Preview {
    BubbleImageView(item: .sentPlaceHolder)
}
