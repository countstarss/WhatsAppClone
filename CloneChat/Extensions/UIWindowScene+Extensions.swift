//
//  UIWindowScene+Extensions.swift
//  CloneChat
//
//  Created by luke on 2024/7/1.
//

import UIKit

extension UIWindowScene {
    static var current: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first {
            $0 is UIWindowScene } as? UIWindowScene
    }
    
    //MARK: - 使用最新语法
    var screenHeight :CGFloat {
        return UIWindowScene.current?.screen.bounds.height ?? 0
    }
    var screenwidth :CGFloat {
        return UIWindowScene.current?.screen.bounds.width ?? 0
    }
    
}
