//
//  UserListConfig.swift
//  Imperium
//
//  Created by Carter Bassler on 10/30/23.
//

import Foundation

enum UserListConfig : Hashable {
    case followers(uid : String)
    case following(uid : String)
    case likes(postId : String)
    case explore
    
    var navigationTitle : String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        case .likes: return "Likes"
        case .explore: return "Explore"
        }
    }
}
