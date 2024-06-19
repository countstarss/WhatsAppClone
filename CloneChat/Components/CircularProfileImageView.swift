//
//  CircularProfileImageView.swift
//  CloneChat
//
//  Created by luke on 2024/6/19.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    let profileImageUrl :String?
    let size: Size
    let fallbackImage:FallBackImage
    
    
    init(_ profileImageUrl: String? = nil, size: Size) {
        self.profileImageUrl = profileImageUrl
        self.size = size
        self.fallbackImage = .directChatIcon
    }
    var body: some View {
//        placeholderImageView()
        if let profileImageUrl {
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .placeholder{ ProgressView() }
                .scaledToFill()
                .frame(width: size.dimension,height: size.dimension)
                .clipShape(Circle())
        } else {
            placeholderImageView()
        }
    }
    
    private func placeholderImageView() -> some View {
        Image(systemName: fallbackImage.rawValue)
            .resizable()
            .scaledToFill()
            .imageScale(.large)
            .foregroundStyle(Color.placeholder)
            .frame(width: size.dimension,height: size.dimension)
            .background(Color.white)
            .clipShape(Circle())
    }
}
extension CircularProfileImageView {
    enum Size {
        case mini,xSmall,small,medium,large,xLarge
        case custom(CGFloat)
        
        var dimension:CGFloat {
            switch self {
            case .mini:
                return 30
            case .xSmall:
                return 40
            case .small:
                return 50
            case .medium:
                return 60
            case .large:
                return 80
            case .xLarge:
                return 120
            case .custom(let dimen):
                return dimen
            }
        }
    }
    
    enum FallBackImage: String {
        case directChatIcon = "person.circle.fill"
        case groupChatIcon = "person.2.circle.fill"
        
        init(forCount membersCount:Int) {
            switch membersCount{
            case 2:
                self = .directChatIcon
            default:
                self = .groupChatIcon
            }
        }
    }
}

// 创建一个extension，添加功能，传入channel,然后利用channel中的内容，填充模板
extension CircularProfileImageView {
    init(_ channel:ChannelItem,size: Size) {
        self.profileImageUrl = channel.coverImageUrl
        self.size = size
        self.fallbackImage = FallBackImage(forCount: channel.membersCount)
    }
}


#Preview {
    CircularProfileImageView(size: .large)
}
