//
//  UserListViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/30/23.
//

import Foundation

class UserListViewModel : ObservableObject {
    @Published var users = [User]()
    
    init() {
    }
    
    func fetchUsers(forConfig config : UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig : config)
        } catch {
            print("DEBUG: Failed to fetch users")
        }
        
    }
}
