//
//  SearchViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation

class SearchViewModel : ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
