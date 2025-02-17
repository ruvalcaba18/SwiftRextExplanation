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
//    let enumViewModel:ObservableViewModel<PokedexViewModel.ViewAction, PokedexViewModel.ViewState>
    
    @StateObject private var detailViewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack {
            pokemonImageDisplayer(pokemonDetail.sprites?.frontDefault)
            pokemonTypesToDisplay(pokemonDetail.types ?? [] )
            ScrollView{
                basicInformationToDisplay(fromPokemon: pokemonDetail)
                abilitiesSection()
            }
        }
        .navigationBarBackButtonHidden(false)
        .navigationTitle(pokemonDetail.name ?? "No Defined")
    }
    
    @ViewBuilder
    private func abilitiesSection() -> some View {
        
            DisclosureGroup(
                isExpanded: $detailViewModel.isAbilitiesDisplay,
                content: {
                    VStack {
                        if let englishEffect = detailViewModel.pokemonAbilities?.englishEffect {
                            
                            Text(" Pokemon Ability Effect: ")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            
                            Text("\(englishEffect.effect ?? "N/A")")
                                .font(.subheadline)
                            
                            Text(" Pokemon short Effect: ")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.top, 15)
                            
                            Text("\(englishEffect.shortEffect ?? "N/A")")
                                .font(.subheadline)
                            
                        } else {
                            Text("No ability effect available in English.")
                                .font(.subheadline)
             
                        }
                    }
                    .foregroundColor(.black)
                    .background(.white)
              
                },
                label: {
                    HStack {
                        Text("Pokemon Abilities")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(red: 1.00, green: 0.91, blue: 0.63, alpha: 1.00)))
                }
            )
            .foregroundStyle(.white)
            .background(Color(UIColor(red: 1.00, green: 0.91, blue: 0.63, alpha: 1.00)))
            .accentColor(.black)
            .onChange(of: detailViewModel.isAbilitiesDisplay) {
                Task {
                    await detailViewModel.getPokemonAbilities(pokemonID: "\(pokemonDetail.id ?? 0)")
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
    
    @ViewBuilder
    private func basicInformationToDisplay(fromPokemon pokemon: PokemonDetail) -> some View {
        VStack{
            Text("Weight: \(pokemon.weight ?? 0 )")
            Text("Height: \(pokemon.height ?? 0 )")
            Text("Base Experience: \(pokemon.baseExperience ?? 0)")
        }
    }

}

#Preview {
    PokemonDetails(pokemonDetail: .previewPokemon,
                   normalViewModel: NormalPokedexViewModel(store: .mock(state: .initial)))
}
