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
            if viewModel.isLoading {
                ProgressView()
            } else {
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
            }
        }
    }
}

#Preview {
    FeedView()
}
