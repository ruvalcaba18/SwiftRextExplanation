//
//  PokemonDetails.swift
//  SwiftRext
//
//  Created by JaelWizeline on 13/02/25.
//

import SwiftUI
import CombineRex

struct PokemonDetails: View {
    
    let pokemonDetail: PokemonDetail
    let normalViewModel: NormalPokedexViewModel
    
    var body: some View {
        Text("Hello, Detail!")
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Pokemon Detail")
            .onAppear{
                print(pokemonDetail)
            }
            .onDisappear{
                normalViewModel.isMainViewPresented = .main
            }
        
    }
}

#Preview {
    PokemonDetails(pokemonDetail: .previewPokemon,
                   normalViewModel: NormalPokedexViewModel(store: .mock(state: .initial)))
}
