//
//  KUser.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import Foundation


struct KUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: KUser, rhs: KUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
