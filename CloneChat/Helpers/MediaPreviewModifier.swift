//
//  MediaPreviewModifier.swift
//  CloneChat
//
//  Created by luke on 2024/6/24.
//

import SwiftUI

struct MediaPreviewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .imageScale(.small)
            .foregroundColor(Color(.systemGray))
            .background(Color(.systemGray5).opacity(0.75))
            .clipShape(Circle())
            .shadow(radius: 5)
                
    }
}

extension View {
    func mediaPreviewModifier() -> some View {
        self.modifier(MediaPreviewModifier())
    }
}
