//
//  ActiveWorkoutView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/13/23.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel = WorkoutViewModel()
    @State private var elapsedTime : Int = 0
    @State private var timer : Timer? = nil
    @State private var isEditingName: Bool = false
    @State var workout : Workout
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Text("Current Workout")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadWorkout(workout: workout)
                        dismiss()
                    }
                } label: {
                    Text("Finish")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
        }
        
        ScrollView {
            VStack {
                
                HStack {
                    if isEditingName {
                        TextField("Workout Name", text: $workout.name)
                            .font(.headline)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                    } else {
                        Text(workout.name)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    if isEditingName {
                        Image(systemName: "checkmark")
                            .imageScale(.medium)
                            .onTapGesture {
                                isEditingName.toggle()
                            }
                    } else {
                        Image(systemName: "pencil")
                            .imageScale(.medium)
                            .onTapGesture {
                                isEditingName.toggle()
                            }
                    }
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                HStack {
                    Text(String(format: "Elapsed Time: %02d:%02d:%02d", elapsedTime / 3600, (elapsedTime % 3600) / 60, elapsedTime % 60))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                    
                ForEach(Array(workout.exercises.enumerated()), id: \.element.id) { index, exercise in
                    ExerciseView(viewModel: ExerciseViewModel(exercise: workout.exercises[index]))
                }
                
                
                Button {
                    workout.exercises.append(Exercise(id : UUID().uuidString, name: "New Exercise", sets: [aSet(id : UUID().uuidString, weight: "", reps: "", isCompleted: false)]))
                } label : {
                    Text("Add Exercise")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width : 360, height : 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedTime += 1
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var ongoingDuration: Int {
        let currentTime = Date().timeIntervalSince1970
        let startTime = workout.start.dateValue().timeIntervalSince1970
        return Int(currentTime - startTime)
    }
}

#Preview {
    ActiveWorkoutView(workout: workout)
}
