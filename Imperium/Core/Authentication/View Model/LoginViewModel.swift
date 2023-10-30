//
//  LoginViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
