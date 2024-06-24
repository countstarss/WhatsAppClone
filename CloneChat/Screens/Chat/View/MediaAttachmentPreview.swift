//
//  MediaAttachmentPreview.swift
//  CloneChat
//
//  Created by luke on 2024/6/24.
//
//  用于预览选择好的媒体文件

import SwiftUI

struct MediaAttachmentPreview: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                audioAttachmentPreview()
                ForEach(0..<12) {_ in
                    thumbnailImageView()
                }
            }
            .padding(.leading,5)
        }
        .frame(height: Constants.listHeight)
        .frame(maxWidth: .infinity)
        .background(.whatsAppWhite)
    }
    
    private func thumbnailImageView() -> some View {
        Button{
            
        }label: {
            Image(.stubImage1)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageDimen, height: Constants.imageDimen)
                .cornerRadius(5)
                .clipped()
            // 添加取消按钮
                .overlay(alignment:.topTrailing){
                    cancleButton()
                        .padding(3)
                }
                .overlay(alignment:.center){
                    playButton("play.fill")
                        .padding(3)
                }
        }
    }
    
    private func cancleButton() -> some View {
        Button{
            
        }label: {
            Image(systemName: "xmark")
                .scaledToFit()
                .imageScale(.small)
                .padding(5)
                .foregroundColor(.whatsAppWhite)
                .background(.white.opacity(0.6))
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
    
    private func playButton(_ systemName:String) -> some View {
        Button{
            
        }label: {
            Image(systemName: systemName)
                .scaledToFit()
                .imageScale(.medium)
                .padding(10)
                .foregroundColor(.white)
                .background(.white.opacity(0.6))
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
    
    private func audioAttachmentPreview() -> some View {
        ZStack{
            LinearGradient(colors: [.green,.green.opacity(0.6),.teal], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            playButton("mic.fill")
                .padding(5)
                .padding(.bottom,15)
        }
        .frame(width: Constants.imageDimen * 2,height: Constants.imageDimen)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        .overlay(alignment:.topTrailing){
            cancleButton()
                .padding(3)
        }
        .overlay(alignment:.bottom){
            Text("test audio name.mp3")
                .lineLimit(1)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity,alignment: .center)
                .padding(1)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .padding(3)
        }
    }
}

extension MediaAttachmentPreview{
    enum Constants {
        static let listHeight : CGFloat = 100
        static let imageDimen : CGFloat = 80
    }
}

#Preview {
    MediaAttachmentPreview()
}
