//
//  PokemonDetailViewModel.swift
//  SwiftRext
//
//  Created by JaelWizeline on 14/02/25.
//

import Foundation
// Get ability https://pokeapi.co/api/v2/ability/{id}
// Get Characteristics https://pokeapi.co/api/v2/characteristic/{id}
// Get Nature https://pokeapi.co/api/v2/nature/{id}
// Get Pokemon Location Areas https://pokeapi.co/api/v2/pokemon/{id or name}/encounters
@MainActor
final class PokemonDetailViewModel: ObservableObject{
    
    private var networkManager: NetworkManager = .shared
    @Published var pokemonAbilities: PokemonEffectData? = .preview
    @Published var isAbilitiesDisplay = false
    
    public func getPokemonAbilities(pokemonID ID: String) async  {
        do {
            pokemonAbilities = try await networkManager.fetchPokemonAbility(withPokemonID: ID)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
