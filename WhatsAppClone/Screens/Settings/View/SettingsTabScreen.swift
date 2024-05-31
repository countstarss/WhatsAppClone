//
//  SettingsTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct SettingsTabScreen: View {
    @State private var searchText:String = ""
    var body: some View {
        NavigationStack{
            List{
                
                SettingHeaderView()
                
                Section{
                    SettingsItemView(item: .broadCastLists)
                    SettingsItemView(item: .starredMessages)
                    SettingsItemView(item: .linkedDevices)
                }
                
                Section{
                    SettingsItemView(item: .account)
                    SettingsItemView(item: .privacy)
                    SettingsItemView(item: .chats)
                    SettingsItemView(item: .notifications)
                    SettingsItemView(item: .storage)
                }
                
                Section{
                    SettingsItemView(item: .help)
                    SettingsItemView(item: .tellFriend)
                    
                }
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            .toolbar{
                trailingNavItem()
            }
        }
    }
}

extension SettingsTabScreen {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
            Button("Sign Out"){
                Task {
                    try? await AuthManager.shared.logOut()
                }
            }
            .bold()
            .foregroundStyle(.red)
        }
    }
}

private struct SettingHeaderView :View {
    var body: some View {
        Section{
            HStack{
                Circle()
                    .frame(width: 45,height: 45)
                
                userInfoTextView()
            }
            SettingsItemView(item: .avatar)
        }
    }
    private func userInfoTextView() -> some View {
        VStack(alignment:.leading,spacing: 4){
            HStack{
                Text("Qs user 12")
                    .font(.title3)
                
                Spacer()
                
                Image("qrcode")
                    .tint(.blue)
                    .padding(5)
                    .frame(width: 30,height: 30)
                    .background(Color(.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            
            Text("Hey,there, i'm using WhatsApp.")
                .font(.system(size: 15))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    SettingsTabScreen()
}
