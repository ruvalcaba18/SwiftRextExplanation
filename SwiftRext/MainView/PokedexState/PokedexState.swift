//
//  AppViewModel.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Foundation

struct PokedexAppState:Equatable {

    var pokemons: [Pokemon]
    var isLoading: Bool = false
    var screen: Screens = .main
    var errorMessage = ""
    var pokemonDetails: [PokemonDetail]
    
    
    static var initial: PokedexAppState {
        .init(pokemons: [], pokemonDetails: [])
    }
    
}

