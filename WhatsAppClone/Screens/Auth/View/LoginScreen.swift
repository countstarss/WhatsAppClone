//
//  LoginScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var authViewModel = AuthScreenModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                AuthHeaderView()
                
                AuthTextField(type: .email, text: $authViewModel.email)
                AuthTextField(type: .password, text: $authViewModel.password)
                
                AuthButton(title: "Login in now") {
                    //
                }
                .disabled(authViewModel.disableLoginButton)
                .padding(.top,24)
                Spacer()
                
                
                forgetPasswordButton()
                siagnUpButton() 
                    .padding(.bottom,24)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.teal.gradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
        }
    }
    
    private func forgetPasswordButton() -> some View {
        Button {
            
        }label: {
            Text("Forget Password?   ")
                .foregroundStyle(.white)
                .bold()
                .font(.system(size: 15))

            
        }
    }
    
    private func siagnUpButton() -> some View {
        
        NavigationLink{
            SignUpScreen()
        }label: {
            HStack{
                Image(systemName: "sparkles")
                
                (
                    Text("Don't have an account ?  ")
                    +
                    Text("Create one").bold()
                )
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
        
    }
    
    
}

#Preview {
    LoginScreen()
}
