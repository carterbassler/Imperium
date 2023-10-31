//
//  SetViewModel.swift
//  Imperium
//
//  Created by Carter Bassler on 10/31/23.
//

import Foundation

class SetViewModel : ObservableObject {
    @Published var set : aSet
    var setNumber : Int
    
    init(set : aSet, setNumber : Int) {
        self.set = set
        self.setNumber = setNumber
    }
    
    func toggleCompletion() async throws {
        set.isCompleted.toggle()
    }
}
