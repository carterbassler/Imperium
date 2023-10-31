//
//  ExerciseView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject var viewModel : ExerciseViewModel
    @State private var showContextMenu: Bool = false
    @State private var showAlert = false
    @State private var showPickExercisePopup : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.exercise.name)
                    .fontWeight(.semibold)
                Spacer()
                Menu {
                    Button("Change Exercise", action: { showPickExercisePopup.toggle() })
                    Button("Delete Exercise", action: { Task { try await viewModel.deleteExercise() }})
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
            
            ForEach(Array(viewModel.exercise.sets.enumerated()), id: \.element.id) { index, set in
                SetView(viewModel: SetViewModel(set: viewModel.exercise.sets[index], setNumber: index + 1))
            }
            .onDelete(perform: viewModel.deleteSet)
            
            Button {
                Task {
                    try await viewModel.addSet()
                }
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
                    PickExerciseView(exerciseName: $viewModel.exercise.name, showPopup: $showPickExercisePopup)
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
    @State var exercisePreview = ExerciseViewModel(exercise: exercise1)
    return ExerciseView(viewModel: exercisePreview)
}
