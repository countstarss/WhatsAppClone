//
//  BubbleAudioView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct BubbleAudioView: View {
    let item : MessageItem
    @State private var sliderValue : Double = 0
    @State private var sliderRange : ClosedRange<Double> = 0...20
    
    var body: some View {
        HStack(alignment:.bottom){
            if item.showGroupPartnerInfo {
                // 由于初始化时图片链接是可选的，所以可传可不传，当然首选是图片url，而不是fallbackImage
                CircularProfileImageView(item.sender?.profileImageUrl,size: .mini)
                // 图片链接在UserItem中，直接将UserItem作为一个属性添加到MessageItem中
            }
            if item.direction == .sent{
                timeStampTextView()
            }
            HStack{
                playButton()
                Slider(value: $sliderValue,in: sliderRange)
                    .tint(.gray)
                Text("00:04")
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(5)
            .frame(width: 200)
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .applyTail(item.direction)
            
            
            if item.direction == .received{
                timeStampTextView()
            }
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 10, x: 0, y: 20)
        .frame(maxWidth: .infinity,alignment: item.alignment)
        .padding(.leading,item.leadingPadding)
        .padding(.trailing,item.trailingPadding)
    }
    
    private func playButton() -> some View {
        Button{
            
        }label: {
            Image(systemName: "play.fill")
                .padding(10)
                .foregroundColor(.gray)
                .background(item.backgroundColor)
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .bubbleWhite : .black)
        }
    }
    
    private func timeStampTextView() -> some View {
        // 插入时间字符串formatToTime（使用Date Extension生成）
        Text(item.timeStmp.formatToTime)
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}




#Preview {
    ScrollView{
        BubbleAudioView(item: .stubMessage[3])
        BubbleAudioView(item: .stubMessage[5])
    }
    .frame(maxWidth: .infinity)
    .background(Color.gray.opacity(0.3))
    .onAppear{
        // 设置滑动条的样式
        let thumbimage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbimage, for: .normal)
    }
}
