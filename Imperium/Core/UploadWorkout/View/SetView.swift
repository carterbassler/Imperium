//
//  SetView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct SetView: View {
    @StateObject var viewModel : SetViewModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(viewModel.setNumber)").frame(width: 50)
                Spacer()
                TextField("lbs", text: $viewModel.set.weight)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(width: 100)
                    .keyboardType(.numberPad)
                Spacer()
                TextField("Reps", text: $viewModel.set.reps)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(width: 100)
                    .keyboardType(.numberPad)
                Spacer()
                HStack {
                    Image(systemName: viewModel.set.isCompleted ? "checkmark.rectangle.fill" : "rectangle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(viewModel.set.isCompleted ? .green : .gray)
                        .onTapGesture {
                            Task {
                                try await viewModel.toggleCompletion()
                            }
                        }
                }
                Spacer()
            }.padding(.vertical)
        }
    }
}

#Preview {
    @State var previewSet = SetViewModel(set: set1, setNumber: 1)
    return SetView(viewModel : previewSet)
}
