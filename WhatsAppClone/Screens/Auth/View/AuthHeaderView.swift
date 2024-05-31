//
//  AuthHeaderView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct AuthHeaderView: View {
    var body: some View {
        HStack{
            Image(.whatsapp)
                .resizable()
                .frame(width: 40,height: 40)
            
            Text("WhatsApp")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    AuthHeaderView()
}
