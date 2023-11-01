//
//  WorkoutViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import Foundation
import Firebase

class WorkoutViewModel : ObservableObject {
//    @Published var workout : Workout
//
//    init(workout : Workout) {
//        self.workout = workout
//    }
    
    func uploadWorkout(workout : Workout) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let workoutRef = Firestore.firestore().collection("workouts").document()
        let encodedWorkout = workout.toDictionary()
            
        var workoutData = encodedWorkout
        workoutData["id"] = workoutRef.documentID
        workoutData["ownerUid"] = uid
        workoutData["end"] = Timestamp()
            
        try await workoutRef.setData(workoutData)
    }
    
    func createWorkout() -> Workout? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        
        let postRef = Firestore.firestore().collection("workouts").document()
        let newWorkout = Workout(id : postRef.documentID, name: "My New Workout", exercises: [], ownerUid: uid, likes : 0, start : Timestamp())
        
        return newWorkout
    }
    
    func addExercise() async throws {
        //workout.exercises.append(Exercise(id : UUID().uuidString, name: "New Exercise", sets: [aSet(id : UUID().uuidString, weight: "", reps: "", isCompleted: false)]))
    }
}
