//
//  ExerciseViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/31/23.
//

import SwiftUI

class ExerciseViewModel : ObservableObject {
    @Binding var exercise : Exercise
    
    init(exercise: Binding<Exercise>) {
            _exercise = exercise
    }
    
    func deleteExercise() async throws {
        print("Delete Exercise")
    }
    
    func changeExercise() async throws {
        print("Change Workout")
    }
    
    func deleteSet(at offsets : IndexSet) {
        exercise.sets.remove(atOffsets: offsets)
    }
    
    func addSet() async throws {
        exercise.sets.append(aSet(id : UUID().uuidString, weight: "", reps: "", isCompleted: false))
    }
}
