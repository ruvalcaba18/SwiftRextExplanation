//
//  PokedexStore.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Foundation
import SwiftRex
import Combine
import CombineRex
import RxSwift
import RxSwiftRex

final class PokedexStore: ReduxStoreBase<PokedexAction, PokedexAppState> {
    
    static func createStoreWithCombine() -> PokedexStore {
        
        let store = PokedexStore(
            subject: .combine(initialValue: .initial),
            reducer: pokedexReducer,
            middleware: PokedexMiddleware())
        return store
    }
    
    
    static func createStoreWithRxSwift() -> PokedexStore {
        let store = PokedexStore(subject: .rx(initialValue: .init(pokemons: [], screen: .main, pokemonDetails: [])),
                                 reducer: pokedexReducer,
                                 middleware: PokedexMiddleware())
        return store
    }
    
}
