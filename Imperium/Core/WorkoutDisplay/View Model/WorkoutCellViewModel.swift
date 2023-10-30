//
//  WorkoutCellViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/25/23.
//

import Foundation

@MainActor
class WorkoutCellViewModel : ObservableObject {
    @Published var workout : Workout
    
    init(workout : Workout) {
        self.workout = workout
        Task { try await checkIfUserLikedWorkout() }
    }
    
    func like() async throws {
        do {
            let workoutCopy = workout
            workout.didLike = true
            workout.likes += 1
            try await WorkoutService.likeWorkout(workoutCopy)
        } catch {
            workout.didLike = false
            workout.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            let workoutCopy = workout
            workout.didLike = false
            workout.likes -= 1
            try await WorkoutService.unlikeWorkout(workoutCopy)
        } catch {
            workout.didLike = true
            workout.likes += 1
        }
    }
    
    func checkIfUserLikedWorkout() async throws {
        self.workout.didLike = try await WorkoutService.checkIfUserLikedWorkout(workout)
    }
}
