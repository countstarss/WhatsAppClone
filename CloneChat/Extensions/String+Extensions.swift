//
//  String+Extensions.swift
//  CloneChat
//
//  Created by 王佩豪 on 2024/6/4.
//

import Foundation

extension String{
    var isEmptyorWhiteSpace :Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
