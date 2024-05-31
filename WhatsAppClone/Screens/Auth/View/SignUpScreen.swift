//
//  IgnUpScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var authViewModel = AuthScreenModel()
    var body: some View {
        VStack{
            Spacer()
            AuthHeaderView()
            AuthTextField(type: .email, text: $authViewModel.email)
            let userNameInputType = AuthTextField.InputType.custom("Username", "at")
            AuthTextField(type: userNameInputType, text: $authViewModel.username)
            AuthTextField(type: .password, text: $authViewModel.password)
            AuthButton(title: "Sign Up") {
                
            
            }
            .disabled(authViewModel.disableSignUpButton)
            .padding(.top,24)
            
            Spacer()
            backButton()
                .padding(.bottom,24)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background{
            LinearGradient(colors: [.green, .green.opacity(0.8),.teal], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    private func backButton() -> some View {
        
        Button{
            dismiss()
        }label: {
            HStack{
                Image(systemName: "sparkles")
                
                (
                    Text("Already have an account ?  ")
                    +
                    Text("Log In").bold()
                )
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
        
    }
}

#Preview {
    SignUpScreen()
}
