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
        VStack(alignment:item.horizontalAlignment){
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
            .background(item.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .applyTail(item.direction)
            
            
            timeStmpTextView()
        }
        .shadow(color: Color(.systemGray3).opacity(0.1), radius: 10, x: 0, y: 20)
        .frame(maxWidth: .infinity,alignment: item.alignment)
        .padding(.leading,item.direction == .received ? 0 : 100)
        .padding(.trailing,item.direction == .received ? 100 : 0)
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
