//
//  ProfileView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/10/23.
//

import SwiftUI

struct ProfileView: View {
    
    let user : User
    
    private let gridItems : [GridItem] = [
        .init(.flexible(),spacing : 1),
        .init(.flexible(),spacing : 1),
        .init(.flexible(),spacing : 1)
    ]
    
    private let imageDimension : CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
            ScrollView {
                //header
                ProfileHeaderView(user: user)
                
                //post grid view
                //PostGridView(user : user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user : User.MOCK_USERS[1])
}
