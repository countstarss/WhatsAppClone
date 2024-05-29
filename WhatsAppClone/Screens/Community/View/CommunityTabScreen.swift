//
//  CommunityTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/29.
//

import SwiftUI

struct CommunityTabScreen: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment:.leading,spacing:10){
                    Image(.communities)
                    
                    Group{
                        Text("Stay connected with a community")
                            .font(.title2)
                        
                        Text("communities bring members in topic=based groups,Any community you're added to will appear here!")
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal,5)
                    
                    exampleButtton()
                        .frame(maxWidth: .infinity,alignment:.center)
                    
                    communityButtton()
                }
                .padding()
            }
            .navigationTitle("Communities")
        }
    }
    
    private func exampleButtton() -> some View {
        Button("See example communities >"){ }
    }
    
    private func communityButtton() -> some View {
        Button{
            
        } label: {
            Label("New community", systemImage: "plus")
                .bold()
                .frame(maxWidth: .infinity,alignment: .center)
                .foregroundStyle(.white)
                .padding(10)
                .background(Color(.systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
        }
    }
}

#Preview {
    CommunityTabScreen()
}
