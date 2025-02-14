//
//  AppState.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import Foundation
import SwiftRex
import CombineRex
import RxSwift
import RxSwiftRex

enum PokedexViewModel {
    
    static func viewModel<S: StoreType>(from store: S) -> ObservableViewModel<ViewAction, ViewState> where S.ActionType == PokedexAction, S.StateType == PokedexAppState {
        store.projection(
                   action: from(viewAction:),
                   state: from(appState:)
        ).asObservableViewModel(initialState: .loaded)
    }
    
    struct ViewState: Equatable {
        
        let title: String
        var pokemonList: [Pokemon]
        var screen:Screens = .main
        var pokemonDetails: [PokemonDetail]

        static var empty: ViewState  {
            .init(title: "Welcome to the Redux Design Pattern", pokemonList: [], pokemonDetails: [])
        }
        static var loaded:ViewState {
            .init(title: "Welcome to the Redux Design Pattern", pokemonList: [
                Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"),
                Pokemon(name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2")
            ], pokemonDetails: [])
        }
    }
    
    enum ViewAction {
          case fetchApiIntially
          case navigateTo(Screens)
      }

    private static func from(viewAction: ViewAction) -> PokedexAction? {
         switch viewAction {
         case .fetchApiIntially:
             return .fetchPokemons
         case .navigateTo(let screen):
             return .navigateTo(screen)
         }
     }
    
    private static func from(appState: PokedexAppState) -> ViewState {
        let pokemonDetailsWithImages = appState.pokemonDetails.map { pokemonDetail in
               return pokemonDetail
           }
           
        return ViewState(title: "Welcomte to Redux framework",
                         pokemonList: appState.pokemons,
                         screen: appState.screen,
                         pokemonDetails: pokemonDetailsWithImages)
    }    
}
