//
//  FeedView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing : 32) {
                    ForEach(viewModel.workouts) { workout in
                        WorkoutCell(workout : workout)
                    }
                }
                .padding(.top,8)
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "paperplane")
//                        .imageScale(.large)
//                }
            }
        }
    }
}

#Preview {
    FeedView()
}
