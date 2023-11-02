//
//  ExerciseView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct ExerciseView: View {
    @State private var showContextMenu: Bool = false
    @State private var showAlert = false
    @State private var showPickExercisePopup : Bool = false
    @Binding var exercise : Exercise
    var body: some View {
        VStack {
            HStack {
                Text(exercise.name)
                    .fontWeight(.semibold)
                Spacer()
                Menu {
                    Button("Change Exercise", action: { showPickExercisePopup.toggle() })
                    Button("Delete Exercise", action: {})
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                }
            }
            .padding()
            
            
            HStack {
                Spacer()
                Text("Set").frame(width: 50)
                Spacer()
                Text("lbs").frame(width: 100)
                Spacer()
                Text("Reps").frame(width: 100)
                Spacer()
                Text("Status").frame(width: 50)
                Spacer()
            }
            
            ForEach(Array(exercise.sets.enumerated()), id: \.element.id) { index, set in
                SetView(set: $exercise.sets[index], setNumber: index + 1)
            }
            
            Button {
                exercise.sets.append(aSet(id : UUID().uuidString, weight: "", reps: "", isCompleted: false))
            } label : {
                Text("Add Set")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width : 360, height : 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
        }
        .overlay(
            Group {
                if showPickExercisePopup {
                    PickExerciseView(exerciseName: $exercise.name, showPopup: $showPickExercisePopup)
                        .frame(width: 300, height: 200)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .onTapGesture {
                            //showPickExercisePopup.toggle()
                        }
                }
            }
        )
    }
}

#Preview {
    @State var exercisePreview = exercise1
    return ExerciseView(exercise: $exercisePreview)
}
