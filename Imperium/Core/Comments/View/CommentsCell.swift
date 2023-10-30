//
//  CommentsCell.swift
//  Imperium
//
//  Created by Carter Bassler on 10/29/23.
//

import SwiftUI

struct CommentCell: View {
    
    let comment : Comment
    
    private var user : User? {
        return comment.user
    }
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            
            VStack(alignment : .leading, spacing : 4) {
                HStack(spacing : 2) {
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    
                    Text(comment.timestamp.timestampString())
                        .foregroundColor(.gray)
                }
                
                Text(comment.commentText)
            }
            .font(.caption)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentCell(comment: comment1)
}
