//
//  CommentsViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/29/23.
//

import Firebase

@MainActor
class CommentsViewModel : ObservableObject {
    @Published var comments = [Comment]()
    
    private let workout : Workout
    private let service : CommentService
    
    init(workout : Workout) {
        self.workout = workout
        self.service = CommentService(workoutId: workout.id)
        
        Task { try await fetchComments()}
    }
    
    func uploadComment(commentText : String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let comment = Comment(posterOwnerUid: workout.ownerUid, commentText: commentText, postId: workout.id, timestamp: Timestamp(), commentOwnerUid: uid)
        
//        self.comments.insert(comment, at : 0)
//        self.comments[0].user = UserService.shared.currentUser
        try await fetchComments()
        try await service.uploadComment(comment)
    }
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = user
        }
    }
}
