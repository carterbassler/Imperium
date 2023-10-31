//
//  FeedViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/12/23.
//

import Foundation
import Firebase

class FeedViewModel : ObservableObject {
    @Published var workouts = [Workout]()
    @Published var isLoading : Bool = true
    
    init() {
        Task { try await fetchWorkouts() }
    }
    
    @MainActor
    func fetchWorkouts() async throws {
        self.workouts = try await WorkoutService.fetchWorkouts()
        self.isLoading = false
    }
}
