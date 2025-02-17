//
//  ContentView.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

import SwiftUI
import Combine
import CombineRex
import SwiftRex

struct PokedexView: View {
    
//    @ObservedObject var viewModelWithEnum: ObservableViewModel<PokedexViewModel.ViewAction, PokedexViewModel.ViewState>
    
   @StateObject var normalViewModel: NormalPokedexViewModel
  
    var body: some View {
           NavigationView {
               VStack {
                   pokedexList
                       .navigationTitle("Pokedex")
               }
           }
       }
}

extension PokedexView {
    
    var pokedexList: some View  {
        VStack {
            List {
                ForEach(normalViewModel.pokemonDetails, id: \.id) { pokemon in
                    pokedexRow(pokemonToDisplay: pokemon)
                }
            }
            .task {
                normalViewModel.fetchPokemons()
//                                viewModelWithEnum.dispatch(.fetchApiIntially)
            }
            .listStyle(.grouped)
        }
    }
    
    @ViewBuilder
    func pokedexRow(pokemonToDisplay: PokemonDetail) ->  some View {
        
        NavigationLink {
            PokemonDetails(pokemonDetail: pokemonToDisplay, normalViewModel: normalViewModel)
        } label: {
            VStack {
                Text(pokemonToDisplay.name ?? "Unknown")
                    .font(.title.smallCaps())
                    .foregroundStyle(.white)
                pokemonImageDisplayer(pokemonToDisplay.sprites?.frontDefault)
                pokemonTypesToDisplay(pokemonToDisplay.types ?? [])
            }
        }
    }
    
    @ViewBuilder
    func pokemonImageDisplayer(_ imgString: String?) -> some View {
        
        if let urlString = imgString {
            
            if let imageData = normalViewModel.imageCache.getObject(forKey: urlString as NSString),
               let uiImage = UIImage(data: imageData) {
                
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .stroke(.white)
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width * 0.45)
                .padding([.horizontal,.vertical],10)
                
            } else {
                ProgressView()
                    .task {
                        await normalViewModel.fetchImage(for: urlString)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func pokemonTypesToDisplay(_ typesEntry: [TypeEntry]) -> some View {
        VStack {
            Text("Pokemon Type: ")
                .font(.title3
                    .smallCaps())
                .foregroundStyle(.white)
            HStack {
                ForEach(typesEntry,id: \.id) { type in
                    PokemonTypePill(type: type)
                }
            }
        }
    }
}

#Preview {
    PokedexView(normalViewModel: NormalPokedexViewModel(store: .mock(state: .initial)))
}
