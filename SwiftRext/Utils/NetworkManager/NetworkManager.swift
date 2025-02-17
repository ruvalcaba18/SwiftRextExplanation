//
//  NetworkManager.swift
//  SwiftRext
//
//  Created by JaelWizeline on 06/02/25.
//

import Foundation

public enum PokemonError:Error {
    case invalidURL
    case badResponse
    case unknown
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    public func fetchPokedexAPI() async throws -> [Pokemon] {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=650") else {
            throw PokemonError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let response = (response as? HTTPURLResponse) , response.statusCode != 200 {
                throw PokemonError.badResponse
            }
            let decodedResponse = try JSONDecoder().decode(PokedexModel.self, from: data)
            return decodedResponse.results
        }catch let error{
            throw PokemonError.unknown
        }
        
    }
    
    public func fetchPokemonDetailsAPI(pokemonName: String) async throws -> PokemonDetail {
        
        guard let url = URL(string:"https://pokeapi.co/api/v2/pokemon/\(pokemonName)") else {
            throw PokemonError.invalidURL
        }
        
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            if let response = (response as? HTTPURLResponse) , response.statusCode != 200 {
                throw PokemonError.badResponse
            }
            let decodedResponse = try JSONDecoder().decode(PokemonDetail.self, from: data)
            return decodedResponse
        }catch let error {
            throw PokemonError.unknown
        }
    }
    
    func fetchPokemonImages(_ imgURL: String) async throws -> Data? {
        
        let cacheKey = NSString(string: imgURL)
        
        if let cachedData = ImageCacheRetriever.shared.getObject(forKey: cacheKey) {
              return cachedData
          }
        
        guard let url = URL(string: imgURL) else {
            throw PokemonError.invalidURL
        }
        
        do {
            let (data, response ) = try await URLSession.shared.data(from: url)
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, responseCode != 200 {
                throw PokemonError.badResponse
            }
            
            ImageCacheRetriever.shared.setObject(object: data as NSData, forkey: cacheKey)

            return data
        }catch {
            throw PokemonError.badResponse
        }
    }
    
    public func fetchPokemonAbility(withPokemonID ID: String?) async throws -> PokemonEffectData {
        
        guard let url = URL(string:"https://pokeapi.co/api/v2/ability/\(ID ?? "" )") else {
            throw PokemonError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(PokemonEffectData.self, from: data)
        }catch let error {
            print(error)
            throw PokemonError.unknown
        }
        
    }
    
    private func handleError() -> String {
        return ""
    }

    
}
