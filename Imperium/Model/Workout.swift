//
//  Workout.swift
//  Imperium
//
//  Created by Carter Bassler on 10/12/23.
//

import Foundation
import FirebaseFirestore

struct Workout : Identifiable, Hashable, Codable {
    let id : String
    var name : String
    var exercises : [Exercise]
    let date : Timestamp
    let ownerUid : String
    var user : User?
    var likes : Int
    
    var didLike : Bool? = false
    
    func toDictionary() -> [String: Any] {
            return [
                "name": name,
                "exercises": exercises.map { exercise in
                    [
                        "id" : exercise.id,
                        "name": exercise.name,
                        "sets": exercise.sets.map { set in
                            [
                                "id" : set.id,
                                "weight": set.weight,
                                "reps": set.reps,
                                "isCompleted": set.isCompleted
                            ]
                        }
                    ]
                },
                "date": date,
                "ownerUid" : ownerUid,
                "likes" : likes
            ]
        }
    
}

struct Exercise : Identifiable, Hashable, Codable {
    let id : String
    var name : String
    var sets : [aSet]
}

struct aSet : Identifiable, Hashable, Codable {
    let id : String
    var weight : String
    var reps : String
    var isCompleted : Bool
}

// Mock Data
let set1 = aSet(id : "1", weight: "50", reps: "10", isCompleted: true)


let sets1 = [
    aSet(id : "1", weight: "50", reps: "10", isCompleted: true),
    aSet(id : "2", weight: "55", reps: "8", isCompleted: true),
    aSet(id : "3", weight: "60", reps: "6", isCompleted: false)
]

let sets2 = [
    aSet(id : "1" ,weight: "20", reps: "15", isCompleted: true),
    aSet(id : "2", weight: "25", reps: "12", isCompleted: true),
    aSet(id : "3", weight: "30", reps: "10", isCompleted: false)
]

let exercise1 = Exercise(id : "1", name: "Bench Press", sets: sets1)
let exercise2 = Exercise(id : "2", name: "Dumbbell Curl", sets: sets2)

let workout = Workout(
    id : NSUUID().uuidString,
    name: "Upper Body Workout",
    exercises: [exercise1, exercise2],
    date: Timestamp(date: Date()),
    ownerUid: "",
    user : User.MOCK_USERS[1],
    likes : 10
)

let emptyWorkout = Workout(id : NSUUID().uuidString, name: "My New Workout", exercises: [], date: Timestamp(), ownerUid: "", user : User.MOCK_USERS[0], likes : 0)
