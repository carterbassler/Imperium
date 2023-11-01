//
//  StartWorkoutView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI
import Firebase

struct StartWorkoutView: View {
    @StateObject var viewModel = WorkoutViewModel()
    var currentWorkout: Workout {
        viewModel.createWorkout() ?? Workout(id : NSUUID().uuidString, name: "Default Workout", exercises: [], ownerUid: "", likes : 0, start : Timestamp())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Start New Workout", destination: ActiveWorkoutView(workout: currentWorkout))
                    
            }
        }
    }
}

#Preview {
    StartWorkoutView()
}
