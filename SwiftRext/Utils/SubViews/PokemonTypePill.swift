//
//  PillShape.swift
//  SwiftRext
//
//  Created by JaelWizeline on 13/02/25.
//

import SwiftUI

struct PokemonTypePill: View {
    let type: TypeEntry
    
    var body: some View {
        Text(type.type?.name?.capitalized ?? "")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(backgroundColor(for: type))
            )
    }
    
    /// Función para obtener el color de fondo según el tipo de Pokémon.
    private func backgroundColor(for types: TypeEntry?) -> Color {
        guard let primaryType = types?.type?.name?.lowercased() else {
            return Color.gray // Color por defecto si no hay tipo
        }
        
        let typeColors: [String: Color] = [
            "normal": Color(.systemGray),
            "fire": Color(.systemRed),
            "water": Color(.systemBlue),
            "electric": Color(.systemYellow),
            "grass": Color(.systemGreen),
            "ice": Color(.systemTeal),
            "fighting": Color(.systemBrown),
            "poison": Color(.systemPurple),
            "ground": Color(.systemOrange),
            "flying": Color(.systemCyan),
            "psychic": Color(.systemPink),
            "bug": Color(.systemGreen),
            "rock": Color(.systemGray),
            "ghost": Color(.systemIndigo),
            "dragon": Color(.systemBlue),
            "dark": Color(.black),
            "steel": Color(.systemGray2),
            "fairy": Color(.systemPink)
        ]
        
        return typeColors[primaryType] ?? Color.gray
    }

}

#Preview {
    PokemonTypePill(type: TypeEntry(slot: 1, type: NamedAPIResource(name: "fire", url: nil)))
}
