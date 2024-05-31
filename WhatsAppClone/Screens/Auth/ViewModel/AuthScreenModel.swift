//
//  AuthScreenModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import Foundation
import Combine

// 什么时候使用final

@MainActor
final class AuthScreenModel :ObservableObject {
    
    /// 00
    //MARK: - Published Property
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    /// 01
    @Published var errorState :(showError :Bool , errorMessage: String) = (false , "Uh ha,error here:")
    
    /// 00
    //MARK: - Compute Property
    var disableLoginButton:Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignUpButton:Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
    
    /// 01
//    @MainActor
    func handleSignUp() async {
        isLoading = true
        do {
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
            print("handleSignUp")
        }catch {
            errorState.errorMessage = "Failed to create an account \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
        }
    }
}
