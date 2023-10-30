//
//  WorkoutService.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import Firebase
import FirebaseFirestore

struct WorkoutService {
    
    private static let workoutsCollection = Firestore.firestore().collection("workouts")
    
    static func fetchWorkouts() async throws -> [Workout] {
        let snapshot = try await workoutsCollection.getDocuments()
        var workouts = try snapshot.documents.compactMap({ try $0.data(as: Workout.self)})
        
        
        for i in 0 ..< workouts.count {
            let workout = workouts[i]
            let ownerUid = workout.ownerUid
            let workoutUser = try await UserService.fetchUser(withUid: ownerUid)
            workouts[i].user = workoutUser
        }
        return workouts
    }
    
    static func fetchUserWorkouts(uid : String) async throws -> [Workout] {
        let snapshot = try await workoutsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as : Workout.self)})
    }
}

// MARK : - Likes

extension WorkoutService {
    static func likeWorkout(_ workout : Workout) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await workoutsCollection.document(workout.id).collection("workout-likes").document(uid).setData([:])
        async let _ = try await workoutsCollection.document(workout.id).updateData(["likes": workout.likes + 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(workout.id).setData([:])
    }
    
    static func unlikeWorkout(_ workout : Workout) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await workoutsCollection.document(workout.id).collection("workout-likes").document(uid).delete()
        async let _ = try await workoutsCollection.document(workout.id).updateData(["likes": workout.likes - 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(workout.id).delete()
    }
    
    static func checkIfUserLikedWorkout(_ workout : Workout) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-likes").document(workout.id).getDocument()
        return snapshot.exists
    }
}
