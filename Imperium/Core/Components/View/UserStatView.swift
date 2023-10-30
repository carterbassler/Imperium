//
//  UserStatView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/10/23.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
        .frame(width : 72)
        .opacity(value == 0 ? 0.5 : 1.0)
    }
}

#Preview {
    UserStatView(value: 12, title: "Cries")
}
