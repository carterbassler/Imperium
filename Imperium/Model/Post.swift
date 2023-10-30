//
//  Post.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id : String
    let ownerUid : String
    let caption : String
    var likes : Int
    let imageUrl : String
    let timestamp : Timestamp
    var user : User?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "Rick",
            likes: 500,
            imageUrl: "rick",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "Morty",
            likes: 700,
            imageUrl: "morty",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "rick",
            likes: 300,
            imageUrl: "headshot",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[2]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            caption: "jerry",
            likes: 300,
            imageUrl: "jerry",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[3]
        ),
    ]
}
