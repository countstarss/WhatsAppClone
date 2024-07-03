//
//  UIApplication+Extension.swift
//  CloneChat
//
//  Created by luke on 2024/7/1.
//

import UIKit

extension UIApplication {
    //MARK: - 关闭键盘
    static func dismissKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
