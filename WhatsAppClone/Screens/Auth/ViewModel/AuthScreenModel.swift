//
//  AuthScreenModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/30.
//

import Foundation


// 什么时候使用final
final class AuthScreenModel :ObservableObject {
    
    //MARK: - Published Property
    @Published var isLoading = false
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    //MARK: - Compute Property
    var disableLoginButton:Bool {
        return email.isEmpty || password.isEmpty || isLoading
    }
    
    var disableSignUpButton:Bool {
        return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }
}
