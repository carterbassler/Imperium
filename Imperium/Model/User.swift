//
//  User.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id : String
    var username : String
    var profileImageUrl : String?
    var fullname : String?
    var bio : String?
    let email : String
    
    var isFollowed : Bool? = false
    var stats : UserStats?
    
    var isCurrentUser : Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats : Codable, Hashable {
    var followingCount : Int
    var followersCount : Int
    var postsCount : Int
}

extension User {
    static var MOCK_USERS : [User] = [
        .init(id: NSUUID().uuidString, username: "carter", profileImageUrl: "jerry", fullname: "Carter Bassler", bio: "Viva Viva", email: "carter@gmail.com"),
        .init(id: NSUUID().uuidString, username: "pat", profileImageUrl: nil, fullname: "Pat Ogonia", bio: "Viva Viva", email: "pat@gmail.com"),
        .init(id: NSUUID().uuidString, username: "rick", profileImageUrl: nil, fullname: "Rick Sanchez", bio: "Viva Viva", email: "rick@gmail.com"),
        .init(id: NSUUID().uuidString, username: "morty", profileImageUrl: nil, fullname: "Morty Sanchez", bio: "Viva Viva", email: "morty@gmail.com"),
        .init(id: NSUUID().uuidString, username: "carter", profileImageUrl: nil, fullname: "Jerry Sanchez", bio: "Viva Viva", email: "jerry@gmail.com")
    ]
}
