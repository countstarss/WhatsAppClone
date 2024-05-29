//
//  UpdataTabScreen.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/28.
//

import SwiftUI

struct UpdataTabScreen: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack{
            List{
                Section{
                    Text("Status")
                        .font(.title3)
                        .bold()
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    StatusSectionHeader()
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    StatusSection()
                        
                }

                Section {
                    RecentUpdatesItemView()
                } header: {
                    Text("RECENT UPDATES")
                }
                
                Section {
                    ChannelListView()
                } header: {
                    channelSectionHeader()
                }


                
            }
            .listStyle(.grouped)
            .navigationTitle("Updates")
            .searchable(text: $searchText)
        }

    }
    
    private func channelSectionHeader() -> some View {
        HStack{
            Text("Channels")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.whatsAppBlack)
                .textCase(nil)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
                    .foregroundColor(.gray)
            })
        }
    }
}

extension UpdataTabScreen{
    enum Constant {
        static let imageDimen :CGFloat = 55
    }
}
//MARK: - StatusSectionHeader
private struct StatusSectionHeader : View {
    var body: some View{
        HStack(alignment:.top){
            Image(systemName: "circle.dashed")
                .font(.title2)
            
            Text("Use status to share photo,textand videos that disappear in 24hours.")
                .font(.system(size: 17))
            +
            Text("     ")
            +
            Text("Status Priovacy")
                .font(.system(size: 17))
                .foregroundColor(.blue).bold()
            
            Image(systemName: "xmark")
                .frame(width: 10)
                .onTapGesture {
                    
                }
            
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

//MARK: - StatusSection
private struct StatusSection:View {
    var body: some View{
        HStack{
            Circle()
                .frame(
                    width: UpdataTabScreen.Constant.imageDimen,
                    height: UpdataTabScreen.Constant.imageDimen
                )
            
            VStack(alignment:.leading){
                Text("My Status")
                    .font(.callout)
                    .bold()
                Text("add to My Status")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            Spacer()
            cameraButton()
            pencilButton()
        }
    }
    private func cameraButton() -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray2))
                .bold()
        })
        .clipShape(Circle())
    }
    private func pencilButton() -> some View {
        Button(action: {
            
        }, label: {
            Image(systemName: "pencil")
                .padding(10)
                .background(Color(.systemGray2))
                .bold()
        })
        .clipShape(Circle())
    }
    
}

//MARK: - RecentUpdatesItemView
private struct RecentUpdatesItemView:View {
    var body: some View{
        HStack{
            Circle()
                .frame(
                    width: UpdataTabScreen.Constant.imageDimen,
                    height: UpdataTabScreen.Constant.imageDimen
                )
            
            VStack(alignment:.leading){
                Text("Luke King")
                    .font(.callout)
                    .bold()
                Text("luke king's Status")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

//MARK: - ChannelListView
private struct ChannelListView :View {
    var body: some View{
        VStack(alignment:.leading){
            Text("Stay update on topic that matter to you,Find channels to follow bellow")
        }
        ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                ForEach(0 ..< 5){_ in
                    ChannelItemView()
                }
            }
        }
        
        Button("Explore More"){
            // action here
        }
        .tint(.blue)
        .bold()
        .buttonStyle(.borderedProminent)
        .clipShape(Capsule())
        .padding()
    }
}

//MARK: - ChannelItemView
private struct ChannelItemView :View {
    var body: some View{
        VStack{
            Circle()
                .frame(
                    width: UpdataTabScreen.Constant.imageDimen,
                    height: UpdataTabScreen.Constant.imageDimen
                )
                .padding(.horizontal)
            Text("Luke king L.K")
            
            Button(action: {
                
            }, label: {
                Text("Follow")
                    .bold()
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.2))
                    .clipShape(Capsule())
                    .padding(2)
            
            })
        }
        .padding(.horizontal,16)
        .padding(.vertical)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

#Preview {
    UpdataTabScreen()
}
