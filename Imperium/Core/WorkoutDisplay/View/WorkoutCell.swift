//
//  WorkoutCell.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct WorkoutCell: View {
    @ObservedObject var viewModel : WorkoutCellViewModel
    @State private var showComments = false
    
    private var workout : Workout {
        return viewModel.workout
    }
    
    private var didLike : Bool {
        return workout.didLike ?? false
    }
    
    init(workout : Workout) {
        self.viewModel = WorkoutCellViewModel(workout: workout)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                if let user = workout.user {
                    CircularProfileImageView(user: user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.username)
                            .font(.headline)
                        
                        Text("2h ago")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
            
            Text(workout.name)
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                ForEach(workout.exercises.indices, id: \.self) { index in
                    let exercise = workout.exercises[index]
                    Text("\(index + 1). \(exercise.name): \(exercise.sets.count) sets")
                }
            }
            .font(.body)
            .padding(.vertical, 5)
            
            HStack {
                Button(action: {
                    handleLikeTapped()
                }) {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .foregroundColor(didLike ? .red : .black)
                }
                
                Spacer()
                    
                Button(action: {
                    showComments.toggle()
                }) {
                    Image(systemName: "bubble.right")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 10)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .sheet(isPresented: $showComments, content: {
            CommentsView(workout : workout)
                .presentationDragIndicator(.visible)
        })
    }
    
    private func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}

#Preview {
    WorkoutCell(workout: workout)
        .previewLayout(.sizeThatFits)
        .padding()
}

//WORKOUT ICONS IN THE FUTURE
//KEEP IN MIND
//NEED DATBASE OF THEM
