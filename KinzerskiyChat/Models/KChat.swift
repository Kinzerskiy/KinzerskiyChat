//
//  KChat.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import UIKit

struct KChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: KChat, rhs: KChat) -> Bool {
        return lhs.id == rhs.id
    }
}
