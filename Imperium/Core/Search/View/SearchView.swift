//
//  SearchView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            UserListView(config : .explore)
                .navigationDestination(for: User.self, destination: {user in
                    ProfileView(user : user)
                })
                .navigationTitle("All Users")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
