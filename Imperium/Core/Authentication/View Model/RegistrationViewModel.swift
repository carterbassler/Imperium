//
//  RegistrationViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailValid = false
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }

    func emailValidationError() -> String? {
        // Check if email is empty
        guard !email.isEmpty else { return "Email cannot be empty" }
        
        // Check if email format is valid
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        guard emailPred.evaluate(with: email) else { return "Invalid email format" }
        
        return nil
    }
    
    func usernameTakenError() -> String? {
        guard !email.isEmpty else { return "Email cannot be empty" }
        return nil
    }
    
    func invalidPasswordError() -> String? {
        guard !email.isEmpty else { return "Email cannot be empty" }
        
        // Check if password is less than 8 characters
        guard password.count >= 8 else { return "Password must be at least 8 characters long" }
        return nil
    }
    
}
