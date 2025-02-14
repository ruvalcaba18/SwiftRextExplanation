//
//  PokedexActions.swift
//  SwiftRext
//
//  Created by JaelWizeline on 04/02/25.
//

import Foundation

enum PokedexAction {
    case fetchPokemons
    case postsLoaded(PokedexFetch)
    case navigateTo(Screens)
}
enum PokedexFetch {
    case successFetch(pokemons: [Pokemon])
    case successDetailsFetch(pokemonDetails: [PokemonDetail])
    case failFetch(error: PokemonError)
}

extension PokedexAction {
    
    public var sendPokemons: PokedexFetch? {
        guard case let .postsLoaded(pokedexFetch) = self else {
            return nil
        }
        return pokedexFetch
    }
    
    public var sendScreen: Screens? {
        guard case let .navigateTo(screens) = self else {
            return nil
        }
        return screens
    }
    
}
