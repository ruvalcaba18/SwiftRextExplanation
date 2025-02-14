//
//  PokedexNormalViewModel.swift
//  SwiftRext
//
//  Created by JaelWizeline on 07/02/25.
//
import Foundation
import SwiftRex
import CombineRex
import Combine

@MainActor
final class NormalPokedexViewModel: ObservableObject {
    
    @Published var pokedexList = [Pokemon]()
    @Published var pokemonDetails = [PokemonDetail]()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var imageCache = [String: Data]()
    @Published var isMainViewPresented: Screens = .main
    @Published var detailPokemonSelected: PokemonDetail?
    private var cancellables = Set<AnyCancellable>()
    private let store: ObservableViewModel<PokedexAction, PokedexAppState>
    
    init(store: ObservableViewModel<PokedexAction, PokedexAppState>) {
        
        self.store = store
        self.store.$state
            .map { $0.pokemonDetails }
            .receive(on: RunLoop.main)
            .sink { [weak self] details in
                self?.pokemonDetails = details
            }
            .store(in: &cancellables)
        
        self.store.$state
            .map { $0.isLoading }
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                self?.isLoading = loading
            }
            .store(in: &cancellables)
        
        self.store.$state
            .map { $0.errorMessage }
            .receive(on: RunLoop.main)
            .sink { [weak self] message in
                self?.errorMessage = message
            }
            .store(in: &cancellables)
        
        self.store.$state
            .map { $0.screen}
            .receive(on: RunLoop.main)
            .sink { [weak self] screen in
                self?.isMainViewPresented = screen
            }.store(in: &cancellables)
        
    }
    
    func fetchPokemons() {
        store.dispatch(.fetchPokemons)
    }
    
    func fetchImage(for url: String) async {
        do {
            let data = try await NetworkManager.shared.fetch(url)
            await MainActor.run {
                imageCache[url] = data
                objectWillChange.send()
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
    
    func moveToDetails(withDetail: PokemonDetail) {
        store.dispatch(.navigateTo(.details))
    }
}
