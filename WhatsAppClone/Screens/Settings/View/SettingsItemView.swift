//
//  SettingsItemView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct SettingsItemView: View {
    let item : SettingsItem
    
    var body: some View {
        
        HStack{
            iconImageView()
                .frame(width: 30,height: 28)
                .padding(3)
                .foregroundColor(.white)
                .background(item.backgroundColor)
                .cornerRadius(10)
            
            Text(item.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func iconImageView() -> some View {
        
        switch item.imageType {
        case .systemImage:
            Image(systemName: item.imageName)
//                .bold()
                .font(.callout)
                
        case .assetImage:
            Image(item.imageName)
                .renderingMode(.template)
                .padding(3)
        }
        
    }
}

#Preview {
    SettingsItemView(item: .chats)
}
