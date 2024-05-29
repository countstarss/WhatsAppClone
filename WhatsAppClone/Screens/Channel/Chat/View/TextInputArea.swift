//
//  TextInputArea.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct TextInputArea: View {
    
    @State private var messageText : String = ""
    var body: some View {
        HStack(alignment:.bottom,spacing:5){
            imagePickerButton()
            audioRecorderButton()
            messageTextField()
            sendMessageButton()
        }
        .padding(.horizontal,4)
        .padding(.top)
        .padding(.bottom,10)
        .background(.whatsAppWhite)
    }
    
    private func messageTextField() -> some View{
        TextField("",text: $messageText)
            .frame(width: 280,height: 30)
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
            
        }label: {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 20))
                .imageScale(.medium)
                .padding(.bottom,2)
                
        }
    }
    
    private func sendMessageButton() -> some View{
        Button{
            
        }label: {
            Image(systemName: "arrow.up")
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(6)
                .background(Color(.systemGray))
                .clipShape(Circle())
        }
    }
    
    private func audioRecorderButton() -> some View{
        Button{
            
        }label: {
            Image(systemName: "mic.fill")
                .fontWeight(.heavy)
                .imageScale(.small)
                .foregroundStyle(.white)
                .padding(5)
                .background(Color(.systemBlue))
                .clipShape(Circle())
        }
    }
}

#Preview {
    TextInputArea()
}
