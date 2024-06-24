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
            HStack(alignment:.bottom){
                // 头像在下方
                if item.showGroupPartnerInfo {
                    // 由于初始化时图片链接是可选的，所以可传可不传，当然首选是图片url，而不是fallbackImage
                    CircularProfileImageView(item.sender?.profileImageUrl,size: .mini)
                    // 图片链接在UserItem中，直接将UserItem作为一个属性添加到MessageItem中
                }
                if item.direction == .sent { shareButton() }
                
                messageTextView()
                    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 10, x: 0, y: 20)
//                    .padding(.vertical)
                    
                    .overlay {
                        playButton()
                            .opacity(item.type == .video ? 1 : 0)
                            .offset(y:-15)
                    }

                if item.direction == .received { shareButton() }
            }
            
            if item.direction == .received { Spacer() }
        }
        // 使用MessageItem规范排版（padding）
        .frame(maxWidth: .infinity,alignment: item.alignment)
        .padding(.leading,item.leadingPadding)
        .padding(.trailing,item.trailingPadding)
        
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
                .overlay(alignment:.bottomTrailing){
                    timeStmpTextView()
                        .padding(2)
                        .padding(.horizontal,3)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(4)
                        
                }

                
            if !(item.text.isEmptyorWhiteSpace ?? true){
                Text(item.text)
                    .padding([.horizontal,.bottom],8)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .frame(width: 220)
            }
        }.padding(5)
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
    ZStack{
        Color.black
        
        VStack{
            BubbleImageView(item: .sentPlaceHolder)
            BubbleImageView(item: .receivePlaceHolder)
        }
    }
}
