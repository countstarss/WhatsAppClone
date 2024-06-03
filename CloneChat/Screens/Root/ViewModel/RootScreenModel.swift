//
//  RootScreenModel.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation
import Combine

final class RootScreenModel:ObservableObject {
    @Published private(set) var authState = AuthState.pending
    private var cancallable : AnyCancellable?
    
    init(){
        cancallable = AuthManager.shared.authState.receive(on: DispatchQueue.main).sink{ [weak self] latestAuthState in
            self?.authState = latestAuthState
        }
    }
}
