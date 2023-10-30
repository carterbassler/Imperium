//
//  Constants.swift
//  Imperium
//
//  Created by Carter Bassler on 10/30/23.
//

import Firebase

struct FirebaseConstants {
    static let Root = Firestore.firestore()
    
    static let UserCollection = Root.collection("users")
    
    static let WorkoutsCollection = Root.collection("workouts")
    
    static let FollowingCollection = Root.collection("following")
    static let FollowersCollection = Root.collection("followers")
    
}
