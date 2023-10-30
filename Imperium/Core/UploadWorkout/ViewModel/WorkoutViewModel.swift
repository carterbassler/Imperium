//
//  WorkoutViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import Foundation
import Firebase

class WorkoutViewModel : ObservableObject {
    
    func uploadWorkout(workout : Workout) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let workoutRef = Firestore.firestore().collection("workouts").document()
        let encodedWorkout = workout.toDictionary()
            
        var workoutData = encodedWorkout
        workoutData["id"] = workoutRef.documentID
        workoutData["ownerUid"] = uid
        workoutData["timestamp"] = Timestamp()
            
        try await workoutRef.setData(workoutData)
    }
    
    func createWorkout() -> Workout? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        
        let postRef = Firestore.firestore().collection("workouts").document()
        let newWorkout = Workout(id : postRef.documentID, name: "My New Workout", exercises: [], date: Timestamp(), ownerUid: uid, likes : 0)
        
        return newWorkout
    }
    
}
