//
//  AuthButton.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct AuthButton: View {
    let title :String
    let onTap: () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    private var backgroundColor:Color {
        return isEnabled ? Color.white : Color.white.opacity(0.3)
    }
    private var textColor:Color {
        return isEnabled ? Color.green : Color.white
    }
    
    var body: some View {
        Button{
            onTap()
        }label: {
            Text(title)
            
            Image(systemName: "arrow.right")
        }
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(textColor)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal,32)
    }
}

#Preview {
    ZStack{
        Color.teal.ignoresSafeArea()
        
        AuthButton(title: "Login"){
            
        }
    }
}
