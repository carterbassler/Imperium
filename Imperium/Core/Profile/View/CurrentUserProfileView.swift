//
//  CurrentUserProfileView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user : User
    
    private let gridItems : [GridItem] = [
        .init(.flexible(),spacing : 1),
        .init(.flexible(),spacing : 1),
        .init(.flexible(),spacing : 1)
    ]
    
    var posts : [Post] {
        return Post.MOCK_POSTS.filter({$0.user?.username == user.username})
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //header
                ProfileHeaderView(user: user)
                
                //post grid view
                //PostGridView(user : user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user : User.MOCK_USERS[1])
}
