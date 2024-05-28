//
//  MainTabView.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/28.
//

import SwiftUI

struct MainTabView: View {
    init(){
        makeTabBarOpaque()
    }
    var body: some View {
        TabView{
            UpdataTabScreen()
                .font(.caption)
                .tabItem {
                    Image(systemName: Tab.update.icon)
                    Text("Updatas")
                }
            placeholderItemView("Calls")
                .font(.caption)
                .tabItem {
                    Image(systemName: Tab.calls.icon)
                    Text("Calls")
                }
            placeholderItemView("Community")
                .font(.caption)
                .tabItem {
                    Image(systemName: Tab.community.icon)
                    Text("Community")
                }
            placeholderItemView("Chats")
                .tabItem {
                    Image(systemName: Tab.chats.icon)
                    Text("Chats")
                }
            placeholderItemView("Settings")
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                    Text("Settings")
                }
        }
    }
    
    //MARK: - 设置不透明的tabBar
    private func makeTabBarOpaque(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}


//MARK: - 设置统一风格
extension MainTabView {
    private func placeholderItemView(_ title: String) -> some View{
        ScrollView{
            ForEach(0..<120){_ in
                Text(title)
                    .font(.largeTitle)
            }
        }
    }
    
    
    private enum Tab {
        case update,calls,community,chats,settings

        
        fileprivate var icon:String{
            switch self {
            case .update:
                return "circle.dashed.inset.filled"
            case .calls:
                return "phone"
            case .community:
                return "person.3"
            case .chats:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
}

#Preview {
    MainTabView()
}
