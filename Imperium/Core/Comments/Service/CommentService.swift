//
//  CommentService.swift
//  Imperium
//
//  Created by Carter Bassler on 10/29/23.
//

import FirebaseFirestoreSwift
import Firebase

struct CommentService {
    
    let workoutId : String
    
    func uploadComment(_ comment : Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        
        try await Firestore.firestore().collection("workouts").document(workoutId).collection("workout-comments").addDocument(data: commentData)
    }
    
    func fetchComments() async throws -> [Comment] {
        let snapshot = try await Firestore.firestore().collection("workouts").document(workoutId).collection("workout-comments").order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as : Comment.self)})
    }
}
