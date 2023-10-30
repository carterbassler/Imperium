//
//  Comment.swift
//  Imperium
//
//  Created by Carter Bassler on 10/29/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Comment : Identifiable, Codable {
    @DocumentID var commentId : String?
    let posterOwnerUid : String
    let commentText : String
    let postId : String
    let timestamp : Timestamp
    let commentOwnerUid : String
    
    var user : User?
    
    var id : String {
        return commentId ?? NSUUID().uuidString
    }
    
}

let comment1 = Comment(posterOwnerUid: "123", commentText: "Test comment for now", postId: "3124", timestamp: Timestamp(), commentOwnerUid: "1223343")
