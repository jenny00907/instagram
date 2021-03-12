//
//  UserService.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/12.
//

import Firebase


struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}

        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            //print("DEBUG: Snapshot is \(snapshot?.data())")

            guard let dictionary = snapshot?.data() else {return}

            let user = User(dictionary: dictionary)
            completion(user)
        }
    }

    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}

            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            print("DEBUG: snapshot success \(users)")
            completion(users)
        }
    }
}
