//
//  ProfileHeaderViewModel.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/12.
//

import Foundation


struct ProfileHeaderViewModel {
    
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user:User) {
        self.user = user
    }
}
