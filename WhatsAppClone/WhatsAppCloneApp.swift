//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/28.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WhatsAppCloneApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginScreen()
//            MainTabView()
//            MessageListView()
        }
    }
}



