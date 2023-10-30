//
//  SetView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/15/23.
//

import SwiftUI

struct SetView: View {
    @Binding var set : aSet
    var setNumber : Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(setNumber)").frame(width: 50)
                Spacer()
                TextField("lbs", text: $set.weight)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(width: 100)
                    .keyboardType(.numberPad)
                Spacer()
                TextField("Reps", text: $set.reps)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(width: 100)
                    .keyboardType(.numberPad)
                Spacer()
                HStack {
                    Image(systemName: set.isCompleted ? "checkmark.rectangle.fill" : "rectangle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(set.isCompleted ? .green : .gray)
                        .onTapGesture {
                            set.isCompleted.toggle()
                        }
                }
                Spacer()
            }.padding(.vertical)
        }
    }
}

#Preview {
    @State var previewSet = aSet(id : "1", weight: "50", reps: "10", isCompleted: true)
    return SetView(set: $previewSet, setNumber: 1)
}
