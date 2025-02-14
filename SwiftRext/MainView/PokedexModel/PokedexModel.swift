//
//  PokedexModel.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

// API TO GET THE LIST OF FIRST 150 https://pokeapi.co/api/v2/pokemon?offset=0&limit=150
import Foundation

struct PokedexModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Identifiable, Codable,Equatable {
    var id: UUID
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.id = UUID()
        self.name = name
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()  
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

