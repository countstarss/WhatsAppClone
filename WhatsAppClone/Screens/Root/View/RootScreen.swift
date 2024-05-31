//
//  RootScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = RootScreenModel()
    
    var body: some View {
        switch viewModel.authState{
            
        case .pending:
            ProgressView()
                .controlSize(.large)
            
        case .loggedIn(let loggedInUser):
            MainTabView()
            
        case .loggedOut:
            LoginScreen()
        }
    }
}

#Preview {
    RootScreen()
}
