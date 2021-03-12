//
//  UserCellViewModel.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/12.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname : String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
