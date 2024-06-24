//
//  BubbleTextView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

/// BubbleImage 
struct BubbleTextView: View {
    
    let item : MessageItem
    
    
    var body: some View {
        HStack(alignment:.bottom,spacing: 3){
            if item.showGroupPartnerInfo {
                // 由于初始化时图片链接是可选的，所以可传可不传，当然首选是图片url，而不是fallbackImage
                CircularProfileImageView(item.sender?.profileImageUrl,size: .mini)
                // 图片链接在UserItem中，直接将UserItem作为一个属性添加到MessageItem中
            }
            if item.direction == .sent{
                timeStampTextView()
            }
            
            Text(item.text)
                .padding(10)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16,style: .continuous))
                .padding(2)
                .applyTail(item.direction)
            if item.direction == .received{
                timeStampTextView()
            }
            
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 10, x: 0, y: 20)
        .frame(maxWidth: .infinity,alignment: item.alignment)
        //用于控制消息显示的长度，数值就是距离另外一边屏幕的距离
        .padding(.leading,item.leadingPadding)
        .padding(.trailing,item.trailingPadding)
    }
    
    private func timeStampTextView() -> some View {
        Text(item.timeStmp.formatToTime)
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}

#Preview {
    ScrollView{
        BubbleTextView(item: .stubMessage[1])
        BubbleTextView(item: .stubMessage[2])
        BubbleTextView(item: .stubMessage[3])
        BubbleTextView(item: .stubMessage[4])
    }
//    .frame(maxWidth: .infinity)
    .background(Color(.systemGray3))
}
