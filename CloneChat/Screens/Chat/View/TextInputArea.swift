//
//  TextInputArea.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI
import PhotosUI

struct TextInputArea: View {
    @State private var ispulsing  = false
    @Binding var textMessage : String
    let viewModel = ChatRoomViewModel(channel: .placeholder)
    // 以下两个属性和VoiceRecorderService中的绑定
    @Binding var isRecording : Bool
    @Binding var elapsedTime : TimeInterval
    let actionHandle :(_ action: userAction) -> Void
    
    // Enable发送按钮
    private var disableSendButton : Bool {
        return !textMessage.isEmptyorWhiteSpace!
    }
    
    var body: some View {
        HStack(alignment:.bottom,spacing:5){
            imagePickerButton()
                .disabled(isRecording)
                .grayscale(isRecording ? 0.8 : 0)
            audioRecorderButton()
            if isRecording {
                audioSessionIndicatorView()
            }else {
                messageTextField()
            }
            sendMessageButton()
                .disabled(disableSendButton)
                .grayscale(disableSendButton ? 1 : 0)
        }
        .padding(.horizontal,4)
        .padding(.top,8)
        .padding(.bottom,15)
        .background(.whatsAppWhite)
        .animation(.spring(bounce:0.5),value: isRecording)
        .onChange(of: isRecording) { oldValue, isRecording in
            if isRecording {
                withAnimation(.easeInOut(duration:1).repeatForever()) {
                    ispulsing = true
                }
            }else {
                ispulsing = false
            }
        }
    }
    
    private func messageTextField() -> some View{
        TextField("",text: $textMessage)
            .frame(width: 240,height: 40)
            .padding(.leading,10)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(textViewBorder())
    }
    
    private func textViewBorder() -> some View {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(Color(.systemGray5), lineWidth: 1)
    }
    
    //MARK: - TextInputArea button
    private func imagePickerButton() -> some View{
        Button{
            // 用enum来表示用户可能进行的几个操作
            // 调用actionHandle，才chatRoom中才能正确的调用到对应的action
            actionHandle(.presentPhotoPicker)
        }label: {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 30))
                .imageScale(.medium)
                .padding(.bottom,2)
                
        }
    }
    
    private func sendMessageButton() -> some View{
        Button{
            actionHandle(.sendMessage)
        }label: {
            Image(systemName: "arrow.up")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(Color(.systemBlue))
                .clipShape(Circle())
        }
        
    }
    
    private func audioRecorderButton() -> some View{
        Button{
            actionHandle(.recordAudio)
        }label: {
            Image(systemName: isRecording ? "square.fill" : "mic.fill")
                .frame(width: 25,height: 25)
                .font(.system(size: 25))
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(isRecording ? .red : .blue)
                .clipShape(Circle())
        }
    }
    
    private func audioSessionIndicatorView() -> some View {
        HStack{
            Button{
                
            }label: {
                Image(systemName: "circle.fill")
                    .foregroundStyle(.red)
                    .font(.caption)
                    .scaleEffect(ispulsing ? 1.8 : 1.0)
                    
            }
            
            Text("Recording Audio")
                .font(.callout)
                .lineLimit(1)
            
            Spacer()
            
            Text(elapsedTime.formatElaspedTime)
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal,10)
        }
        .frame(width: 240,height: 40)
        .padding(.leading,10)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.blue.opacity(0.1))
        )
        .overlay(textViewBorder())
    }
}
extension TextInputArea {
    enum userAction {
        case presentPhotoPicker
        case sendMessage
        case recordAudio
    }
}

#Preview {
    ZStack{
        Color.white
        
        TextInputArea(textMessage: .constant(""),isRecording: .constant(false), elapsedTime: .constant(0)){ action in
            //
        }
    }
}
