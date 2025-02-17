//
//  PokemonDetailModels.swift
//  SwiftRext
//
//  Created by JaelWizeline on 14/02/25.
//

import Foundation

struct Language: Codable {
    let name: String?
    let url: String?
    
    init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
    
    static var preview: Language {
        Language(name: "en", url: "https://pokeapi.co/api/v2/language/9/")
    }
}

struct EffectEntry: Codable, Identifiable {
    var id = UUID()
    var effect: String?
    let language: Language?
    var shortEffect: String?
    
    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
    
    init(effect: String? = nil, language: Language? = nil, shortEffect: String? = nil) {
        self.effect = effect
        self.language = language
        self.shortEffect = shortEffect
    }
    
    static var preview: EffectEntry {
        EffectEntry(effect: "Absorbs water moves and heals.", language: .preview, shortEffect: "Heals 1/4 max HP.")
    }
    
    var englishDescription: String? {
        guard let languageName = language?.name, languageName.lowercased() == "en" else {
            return nil
        }
        return effect
    }
    
    var englishShortEffect: String? {
        guard let languageName = language?.name, languageName.lowercased() == "en" else {
            return nil
        }
        return shortEffect
    }
}

struct VersionGroup: Codable {
    let name: String?
    let url: String?
    
    init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
    
    static var preview: VersionGroup {
        VersionGroup(name: "ruby-sapphire", url: "https://pokeapi.co/api/v2/version-group/5/")
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String?
    let language: Language?
    let versionGroup: VersionGroup?
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, versionGroup = "version_group"
    }
    
    init(flavorText: String? = nil, language: Language? = nil, versionGroup: VersionGroup? = nil) {
        self.flavorText = flavorText
        self.language = language
        self.versionGroup = versionGroup
    }
    
    static var preview: FlavorTextEntry {
        FlavorTextEntry(flavorText: "Restores HP if hit by a Water-type move.", language: .preview, versionGroup: .preview)
    }
}

struct PokemonEffectData: Codable {
    let effectChanges: [EffectEntry]?
    let effectEntries: [EffectEntry]?
    let flavorTextEntries: [FlavorTextEntry]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case name
    }
    
    init(effectChanges: [EffectEntry]? = nil,
         effectEntries: [EffectEntry]? = nil,
         flavorTextEntries: [FlavorTextEntry]? = nil,
         name: String? = nil) {
        self.effectChanges = effectChanges
        self.effectEntries = effectEntries
        self.flavorTextEntries = flavorTextEntries
        self.name = name
    }
    
    static var preview: PokemonEffectData {
        PokemonEffectData(
            effectChanges: [.preview],
            effectEntries: [.preview],
            flavorTextEntries: [.preview],
            name: ""
        )
    }

    var englishEffect: EffectEntry? {
        let allEffects = (effectEntries ?? []) + (effectChanges ?? [])
        
        return allEffects.reduce(into: EffectEntry()) { result, effect in
            
            guard let languageName = effect.language?.name, languageName.lowercased() == "en" else { return }
            
            if let effectText = effect.effect {
                result.effect = (result.effect ?? "") + "\n" + effectText
            }
            if let shortEffectText = effect.shortEffect {
                result.shortEffect = (result.shortEffect ?? "") + "\n" + shortEffectText
            }
        }
    }

}




struct Description: Codable {
    let description: String?
    let language: Language?
    
    init(description: String = "", language: Language = Language()) {
        self.description = description
        self.language = language
    }
    
    static var preview: Description {
        Description(description: "Somewhat vain", language: .preview)
    }
}

struct HighestStat: Codable {
    let name: String?
    let url: String?
    
    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
    
    static var preview: HighestStat {
        HighestStat(name: "special-defense", url: "https://pokeapi.co/api/v2/stat/5/")
    }
}

struct PokemonCharacteristic: Codable {
    let descriptions: [Description]?
    let geneModulo: Int?
    let highestStat: HighestStat?
    let id: Int?
    let possibleValues: [Int]?
    
    init(
        descriptions: [Description] = [],
        geneModulo: Int = 0,
        highestStat: HighestStat = HighestStat(),
        id: Int = 0,
        possibleValues: [Int] = []
    ) {
        self.descriptions = descriptions
        self.geneModulo = geneModulo
        self.highestStat = highestStat
        self.id = id
        self.possibleValues = possibleValues
    }
    
    static var preview: PokemonCharacteristic {
        PokemonCharacteristic(
            descriptions: [.preview],
            geneModulo: 1,
            highestStat: .preview,
            id: 11,
            possibleValues: [1, 6, 11, 16, 21, 26, 31]
        )
    }
}

struct Nature: Codable, Identifiable {
    let id: Int?
    let name: String?
    let decreasedStat: StatReference?
    let hatesFlavor: StatReference?
    let increasedStat: StatReference?
    let likesFlavor: StatReference
    let moveBattleStylePreferences: [MoveBattleStylePreference]?
    let names: [NameEntry]?
    let pokeathlonStatChanges: [PokeathlonStatChange]?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case decreasedStat = "decreased_stat"
        case hatesFlavor = "hates_flavor"
        case increasedStat = "increased_stat"
        case likesFlavor = "likes_flavor"
        case moveBattleStylePreferences = "move_battle_style_preferences"
        case names
        case pokeathlonStatChanges = "pokeathlon_stat_changes"
    }
    
    init(
            id: Int = 0,
            name: String = "",
            decreasedStat: StatReference? = .preview,
            hatesFlavor: StatReference? = .preview,
            increasedStat: StatReference? = .preview,
            likesFlavor: StatReference = .preview,
            moveBattleStylePreferences: [MoveBattleStylePreference]? = [.preview],
            names: [NameEntry]? = [.preview],
            pokeathlonStatChanges: [PokeathlonStatChange]? = [.preview]
        ) {
            self.id = id
            self.name = name
            self.decreasedStat = decreasedStat
            self.hatesFlavor = hatesFlavor
            self.increasedStat = increasedStat
            self.likesFlavor = likesFlavor
            self.moveBattleStylePreferences = moveBattleStylePreferences
            self.names = names
            self.pokeathlonStatChanges = pokeathlonStatChanges
        }
    
    static var preview: Nature {
        return .init(id: 0,
                     name: "",
                     decreasedStat: .preview,
                     hatesFlavor: .preview,
                     increasedStat: .preview,
                     likesFlavor: .preview,
                     moveBattleStylePreferences:  [.preview],
                     names: [.preview],
                     pokeathlonStatChanges: [.preview])
    }
}

struct PokeathlonStatChange: Codable {
    let maxChange: Int?
    let pokeathlonStat: PokeathlonStat?
    
    enum CodingKeys: String, CodingKey {
        case maxChange = "max_change"
        case pokeathlonStat = "pokeathlon_stat"
    }
    
    init(maxChange: Int = 0, pokeathlonStat: PokeathlonStat = .preview ) {
            self.maxChange = maxChange
            self.pokeathlonStat = pokeathlonStat
        }
    
    static var preview: Self {
        return .init(maxChange: 100,pokeathlonStat: .preview)
    }
}

struct StatReference: Codable {
    let name: String?
    let url: String?
    
    init(name: String = "Stat", url: String = "http://example.com") {
            self.name = name
            self.url = url
        }
    static var preview: Self {
        return .init(name:"Stat", url: "http://example.com")
    }
}

struct MoveBattleStyle: Codable {
    let name: String?
    let url: String?
    
    init(name: String = "Defensive", url: String = "http://example.com") {
           self.name = name
           self.url = url
       }
    
    static var preview: Self {
        return .init(name: "Defensive", url: "http://example.com")
    }
}

struct NameEntry: Codable {
    let language: Language?
    let name: String?
    
    init(language: Language = Language(name: "English"), name: String = "Name") {
           self.language = language
           self.name = name
       }
    
    static var preview: NameEntry{
        return .init(language: .preview, name: "Name")
    }
}

struct MoveBattleStylePreference: Codable {
    let highHpPreference: Int
    let lowHpPreference: Int
    let moveBattleStyle: MoveBattleStyle
    
    enum CodingKeys: String, CodingKey {
        case highHpPreference = "high_hp_preference"
        case lowHpPreference = "low_hp_preference"
        case moveBattleStyle = "move_battle_style"
    }
    
    init(
           highHpPreference: Int = 0,
           lowHpPreference: Int = 0,
           moveBattleStyle: MoveBattleStyle = MoveBattleStyle()
       ) {
           self.highHpPreference = highHpPreference
           self.lowHpPreference = lowHpPreference
           self.moveBattleStyle = moveBattleStyle
       }
    
    static var preview: MoveBattleStylePreference {
        return .init(highHpPreference: 0,
                     lowHpPreference:  0,
                     moveBattleStyle: .preview)
    }
}

struct PokeathlonStat: Codable {
    let name: String?
    let url: String?
    
    init(name: String = "Speed", url: String = "http://example.com") {
           self.name = name
           self.url = url
       }
    
    static var preview: Self {
        return .init(name:"Speed", url: "http://example.com")
    }
}

struct LocationAreaEncounter: Codable {
    let locationArea: NamedAPIResource
    let versionDetails: [VersionEncounterDetail]
    
    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
        case versionDetails = "version_details"
    }
}

struct VersionEncounterDetail: Codable {
    let version: NamedAPIResource
    let maxChance: Int
    let encounterDetails: [EncounterDetail]
    
    enum CodingKeys: String, CodingKey {
        case version
        case maxChance = "max_chance"
        case encounterDetails = "encounter_details"
    }
}

struct EncounterDetail: Codable {
    let chance: Int
    let conditionValues: [NamedAPIResource]
    let maxLevel: Int
    let method: NamedAPIResource
    let minLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case chance
        case conditionValues = "condition_values"
        case maxLevel = "max_level"
        case method
        case minLevel = "min_level"
    }
}

