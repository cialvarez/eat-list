//
//  EatListViewModel.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

class EatListViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        var stateChanged: (State) -> Void
    }
    
    enum State {
        case loading
        case error
        case finished
    }
    
    func transform(input: Input) -> Output {
        fatalError("Not yet implemented!")
    }
}
