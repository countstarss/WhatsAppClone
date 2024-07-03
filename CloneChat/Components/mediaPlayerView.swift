//
//  mediaPlayerView.swift
//  CloneChat
//
//  Created by luke on 2024/6/25.
//

import SwiftUI
import AVKit

struct mediaPlayerView: View {
    let player :AVPlayer
    let dismissPlayer : () -> Void
    // 调用时直接将代码加在mediaPlayerView()后面，会被button调用
    
    var body: some View {
        VideoPlayer(player: player)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .ignoresSafeArea()
            .overlay(alignment:.topLeading){
                cancelButton()
                    .padding()
            }
            .onAppear{ player.play() }
    }
    
    private func cancelButton() -> some View {
        Button {
            dismissPlayer()
        } label: {
            Image(systemName: "xmark")
                .scaledToFit()
                .imageScale(.large)
                .padding(10)
                .foregroundStyle(.white)
                .background(Color.white.opacity(0.5))
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding(2)
                .bold()
        }

    }
}

