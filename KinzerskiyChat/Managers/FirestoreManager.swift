//
//  FirestoreManager.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 12.07.2023.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    
    func saveProfileWith(id: String, email: String, username: String?, avatarStringURL: String?, description: String?, sex: String?, completion: @escaping (Result <KUser, Error>) -> Void) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserErrors.notFilled))
           return
        }
        
        let kuser = KUser(username: username!,
                          email: email,
                          description: description!,
                          sex: sex!,
                          avatarStringURL: "nil",
                          id: id)
        
        self.usersRef.document(kuser.id).setData(kuser.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(kuser))
            }
        }
    }
}
