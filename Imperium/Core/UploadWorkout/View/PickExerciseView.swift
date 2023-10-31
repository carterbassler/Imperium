//
//  AddExerciseView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/17/23.
//

import SwiftUI

struct PickExerciseView: View {
    @Binding var exerciseName: String
    @Binding var showPopup: Bool
    var body: some View {
        VStack(spacing: 20) {
            TextField("Exercise Name", text: $exerciseName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save Changes") {
                showPopup = false
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    @State var exerciseNamePreview = "Squats"
    @State var showPopupPreview = true
    return PickExerciseView(exerciseName: $exerciseNamePreview, showPopup : $showPopupPreview)
}
