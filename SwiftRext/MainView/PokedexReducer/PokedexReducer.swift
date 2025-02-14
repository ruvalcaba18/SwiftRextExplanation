//
//  PokedexReducer.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Foundation
import SwiftRex

let pokedexReducer = Reducer<PokedexAction, PokedexAppState>.reduce { action, state in
    switch action {
    
    case .fetchPokemons:
        break
    case .postsLoaded(let fetch):
        switch fetch {
        case .successFetch(pokemons: let pokemons):
            state.pokemons = pokemons
        case .failFetch(error: let error):
            state.errorMessage = error.localizedDescription
        case .successDetailsFetch(pokemonDetails: let pokemonDetails):
            state.pokemonDetails = pokemonDetails
        }
    case .navigateTo(let screen ):
        state.screen = screen
    }
 
}


