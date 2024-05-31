//
//  LoginScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var authScreenModel = AuthScreenModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                AuthHeaderView()
                
                AuthTextField(type: .email, text: $authScreenModel.email)
                AuthTextField(type: .password, text: $authScreenModel.password)
                
                AuthButton(title: "Login in now") {
                    
                }
                .disabled(authScreenModel.disableLoginButton)
                .padding(.top,24)
                Spacer()
                
                
                forgetPasswordButton()
                signUpButton() 
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
    
    private func signUpButton() -> some View {
        
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
