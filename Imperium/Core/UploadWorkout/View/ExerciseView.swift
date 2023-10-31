//
//  ExerciseView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise : Exercise
    @State private var showContextMenu: Bool = false
    @State private var showAlert = false
    var body: some View {
        VStack {
            HStack {
                Text(exercise.name)
                    .fontWeight(.semibold)
                Spacer()
                Menu {
                    Button("Change Exercise", action: changeWorkout)
                    Button("Delete Exercise", action: deleteExercise)
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
            
            //List {
                ForEach(Array(exercise.sets.enumerated()), id: \.element.id) { index, set in
                    SetView(set: $exercise.sets[index], setNumber: index + 1)
                }
                .onDelete(perform: deleteSet)
            //}
//            .listStyle(PlainListStyle())
//            .environment(\.defaultMinListRowHeight, 0)
            
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
    }
}

func deleteExercise() {
    
}

func deleteSet(at offsets: IndexSet) {
    print("DELETED")
}

func changeWorkout() {
    print("Hello")
}

#Preview {
    @State var exercisePreview = exercise1
    return ExerciseView(exercise: $exercisePreview)
}
