//
//  MediaAttachmentPreview.swift
//  CloneChat
//
//  Created by luke on 2024/6/24.
//
//  用于预览选择好的媒体文件

import SwiftUI

struct MediaAttachmentPreview: View {
    let mediaAttachments :[MediaAttachment]
    let actionHandler: (_ action: userAction) -> Void
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(mediaAttachments) {attachment in
                    if attachment.type == .audio{
                        audioAttachmentPreview(attachment)
                    }else{
                        thumbnailImageView(attachment)
                    }
                }
            }
            .padding(.leading,5)
            .padding(.vertical,5)
        }
        .frame(height: Constants.listHeight)
        .frame(maxWidth: .infinity)
        .background(.whatsAppWhite)
    }
    
    private func thumbnailImageView(_ attachment:MediaAttachment) -> some View {
        Button{
            
        }label: {
            // attachment不包括thumbnail，所以添加一个属性thumbnail
            Image(uiImage: attachment.thumbnail)
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageDimen, height: Constants.imageDimen)
                .cornerRadius(5)
                .clipped()
                .overlay(alignment:.topTrailing){
                    cancleButton(attachment)
                        .padding(3)
                }
                .overlay(alignment:.center){
                    playButton("play.fill", item: attachment)
                        .padding(3)
                        .opacity(attachment.type == .video(UIImage(), .stubURL) ? 1.0 : 0.0)
                }
        }
    }
    
    private func cancleButton(_ attachment:MediaAttachment) -> some View {
        Button{
            actionHandler(.remove(attachment))
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
    
    private func playButton(_ systemName:String,item:MediaAttachment) -> some View {
        Button{
            actionHandler(.play(item))
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
    
    private func audioAttachmentPreview(_ attachment:MediaAttachment) -> some View {
        ZStack{
            LinearGradient(colors: [.green,.green.opacity(0.6),.teal], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            playButton("mic.fill", item: attachment)
                .padding(5)
                .padding(.bottom,15)
        }
        .frame(width: Constants.imageDimen * 2,height: Constants.imageDimen)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
        .overlay(alignment:.topTrailing){
            cancleButton(attachment)
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
        static let listHeight : CGFloat = 90
        static let imageDimen : CGFloat = 80
    }
    enum userAction {
        case play(_ item: MediaAttachment)
        case remove(_ item: MediaAttachment)
    }
}

#Preview {
    MediaAttachmentPreview(mediaAttachments: []){ action in
        
    }
}
