//
//  ProfileViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/30/23.
//

import Foundation

@MainActor
class ProfileViewModel : ObservableObject {
    @Published var user : User
    @Published var isLoading : Bool = false
    
    init(user : User) {
        print("DEBUG: Did init..")
        self.user = user
    }
    
    func fetchUserStats() {
        guard user.stats == nil else {
            print("DEBUG: User stats already exists \(user.stats)")
            return
        }
        isLoading = true
        Task {
            defer { isLoading = false }
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

// MARK: - Following

extension ProfileViewModel {
    func follow() {
        isLoading = true
        Task {
            defer { isLoading = false }
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        isLoading = true
        Task {
            defer { isLoading = false }
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }

    }
    
    func checkIfUserIsFollowed() {
        guard user.isFollowed == nil else {
            return
        }
        isLoading = true
        Task {
            defer { isLoading = false }
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}
