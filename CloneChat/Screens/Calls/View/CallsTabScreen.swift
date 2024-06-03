//
//  CallsTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/28.
//

import SwiftUI

struct CallsTabScreen: View {
    @State private var searchText :String = ""
    @State private var callHistory =  CallHistory.all
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    CreateCallLinkSection()
                }
                
                Section {
                    ForEach(0..<10){_ in
                        RecentCallItemView()
                    }
                } header: {
                    Text("Recent")
                        .textCase(nil)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.whatsAppBlack)
                }

            }
            .navigationTitle("Calls")
            .searchable(text: $searchText)
            .toolbar{
                CallsTabScreen().leadingNavItem()
//                Spacer()
                CallsTabScreen().trailingNavItem()
                
                principalNavItem()
            }
        }
    }
}

//MARK: - ToolbarContentBuilder
extension CallsTabScreen{
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent{
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    
                }label: {
                    Text("Edit")
                }
            }
    }
    
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent{
        ToolbarItem(placement: .topBarTrailing) {
                Button{
                    
                }label: {
                    Image(systemName: "phone.arrow.up.right")
                }
            }
    }
    
    @ToolbarContentBuilder
    private func principalNavItem() -> some ToolbarContent{
        ToolbarItem(placement: .principal) {
            Picker("",selection: $callHistory) {
                ForEach(CallHistory.allCases){item in
                    Text(item.rawValue.capitalized)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
        }
    }
    
    private enum CallHistory :String ,CaseIterable,Identifiable{
        case all,missed
        
        var id : String{
            return rawValue
        }
    }
}


//MARK: - CreateCallLinkSection
private struct CreateCallLinkSection :View {
    var body:some View {
        HStack{
            Image(systemName: "link")
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(Circle())
            
            VStack(alignment:.leading){
                Text("Create Call Link")
                    .font(.callout)
                    .foregroundStyle(.blue)
                
                Text("Share a link to your WhatsApp call")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical,4)
    }
}


//MARK: - RecentCallItemView
private struct RecentCallItemView : View{
    var body: some View{
        HStack{
            Circle()
                .frame(width: 45,height: 45)
            
            rencentCallsTextView()
            
            Spacer()
            
            Text("Yesterday")
                .foregroundStyle(.secondary)
                .font(.system(size: 16))
            
            Image(systemName: "info.circle")
        }
    }
    
    private func rencentCallsTextView() -> some View {
        VStack{
            Text("John Smith")
                .font(.subheadline)
                .fontWeight(.regular)
            
            HStack{
                Image(systemName: "phone.arrow.up.right")
                Text("Outgoing")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CallsTabScreen()
}
