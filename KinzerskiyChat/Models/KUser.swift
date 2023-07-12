//
//  KUser.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import Foundation


struct KUser: Hashable, Decodable {
    var username: String
    var email: String
    var description: String
    var sex: String
    var avatarStringURL: String
    var id: String
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["sex"] = sex
        rep["email"] = email
        rep["description"] = description
        rep["avatarStringURL"] = avatarStringURL
        rep["uid"] = id
        return rep
    }
    
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
