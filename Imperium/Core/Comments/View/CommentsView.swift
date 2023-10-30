//
//  CommentsView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/29/23.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    @StateObject var viewModel : CommentsViewModel
    
    private var currentUser : User? {
        UserService.shared.currentUser
    }
    
    init(workout : Workout) {
        self._viewModel = StateObject(wrappedValue: CommentsViewModel(workout: workout))
    }
    
    var body: some View {
        VStack {
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top,24)
            
            Divider()
            
            ScrollView {
                LazyVStack(spacing : 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
            .padding(.top)
            
            Divider()
            
            HStack(spacing : 12) {
                CircularProfileImageView(user: currentUser, size: .xSmall)
                
                ZStack(alignment : .trailing) {
                    TextField("Add a Comment", text : $commentText, axis : .vertical)
                        .font(.footnote)
                        .padding(12)
                        .padding(.trailing, 40)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }
                    Button {
                        Task {
                            try await viewModel.uploadComment(commentText: commentText)
                            commentText = ""
                        }
                    } label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .padding(.horizontal)
                }
            }
            .padding(12)
        }
    }
}

#Preview {
    CommentsView(workout : workout)
}
