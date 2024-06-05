//
//  FirebaseConstants.swift
//  WhatsAppClone
//
//  Created by 王佩豪 on 2024/5/31.
//

import Foundation
import Firebase
import FirebaseStorage

enum FirebaseConstants{
    private static let DatabaseRef = Database.database(url:"https://whatsapp-a26a2-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    static let UserRef = DatabaseRef.child("user")
    
    static let ChannelRef = DatabaseRef.child("channels")
    static let MessageRef = DatabaseRef.child("channels-messages")
    static let UserChannelRef = DatabaseRef.child("user-channels")
    static let UserDirectChannels = DatabaseRef.child("user-direct-channels")
    
}
