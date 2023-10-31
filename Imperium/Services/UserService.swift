//
//  UserService.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation
import Firebase

class UserService {
    
    @Published var currentUser : User?
    @Published var isLoading : Bool = false
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser = try await Firestore.firestore().collection("users").document(uid).getDocument(as : User.self)
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchUsers(forConfig config : UserListConfig) async throws -> [User] {
        switch config {
        case .followers(let uid):
            return try await fetchFollowers(uid: uid)
        case .following(let uid):
            return try await fetchFollowing(uid: uid)
        case .likes(let postId):
            return try await fetchPostLikesUsers(postId: postId)
        case .explore:
            return try await fetchAllUsers()
        }
    }
    
    private static func fetchFollowers(uid : String) async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").getDocuments()
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchFollowing(uid : String) async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirebaseConstants.FollowingCollection.document(uid).collection("user-following").getDocuments()
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchPostLikesUsers(postId : String) async throws -> [User] {
        return []
    }
    
    private static func fetchUsers(_ snapshot : QuerySnapshot) async throws -> [User] {
        var users = [User]()
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        return users
    }
}

// MARK: - Following

extension UserService {
    static func follow(uid : String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ =  try await FirebaseConstants.FollowingCollection.document(currentUid).collection("user-following").document(uid).setData([:])
        async let _ =  try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").document(currentUid).setData([:])
    }
    
    static func unfollow(uid : String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ =  try await FirebaseConstants.FollowingCollection.document(currentUid).collection("user-following").document(uid).delete()
        async let _ =  try await FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").document(currentUid).delete()
    }
    
    static func checkIfUserIsFollowed(uid : String) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirebaseConstants.FollowingCollection.document(currentUid).collection("user-following").document(uid).getDocument()
        return snapshot.exists
    }
}

// MARK: - User Stats

extension UserService {
    static func fetchUserStats(uid : String) async throws -> UserStats {
        async let followingCount = FirebaseConstants.FollowingCollection.document(uid).collection("user-following").getDocuments().count
        
        async let followersCount = FirebaseConstants.FollowersCollection.document(uid).collection("user-followers").getDocuments().count
        
        async let postsCount = FirebaseConstants.WorkoutsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments().count
        
        print("DEBUG: Did call fetch user stats..")
        return try await .init(followingCount: followingCount, followersCount: followersCount, postsCount: postsCount)
    }
}
