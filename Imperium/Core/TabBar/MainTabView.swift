//
//  MainTabView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/10/23.
//

import SwiftUI
import Firebase

struct MainTabView: View {
    let user : User
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection : $selectedIndex) {
            FeedView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            SearchView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            StartWorkoutView()
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "dumbbell")
                }.tag(2)
            CurrentUserProfileView(user: user)
                .onAppear {
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(3)
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView(user : User.MOCK_USERS[0])
}
