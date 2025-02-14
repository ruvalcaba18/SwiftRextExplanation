//
//  PokemonModel.swift
//  SwiftRext
//
//  Created by JaelWizeline on 30/01/25.
//

//  URL TO GET THE DETAIL https://pokeapi.co/api/v2/pokemon/{id or name}/
import Foundation

struct PokemonDetail: Codable, Equatable {
    
    let id: Int?
    let name: String?
    let baseExperience: Int?
    let height: Int?
    let isDefault: Bool?
    let order: Int?
    let weight: Int?
    let abilities: [AbilityEntry]?
    let forms: [NamedAPIResource]?
    let gameIndices: [GameIndex]?
    let heldItems: [HeldItem]?
    let locationAreaEncounters: String?
    let moves: [MoveEntry]?
    let species: NamedAPIResource?
    let sprites: Sprites?
    let cries: Cries?
    let stats: [StatEntry]?
    let types: [TypeEntry]?
    let pastTypes: [PastType]?
    
    static func == (lhs: PokemonDetail, rhs: PokemonDetail) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.baseExperience == rhs.baseExperience &&
        lhs.height == rhs.height &&
        lhs.isDefault == rhs.isDefault &&
        lhs.order == rhs.order &&
        lhs.weight == rhs.weight &&
        lhs.abilities == rhs.abilities &&
        lhs.forms == rhs.forms &&
        lhs.gameIndices == rhs.gameIndices &&
        lhs.heldItems == rhs.heldItems &&
        lhs.locationAreaEncounters == rhs.locationAreaEncounters &&
        lhs.moves == rhs.moves &&
        lhs.species == rhs.species &&
        lhs.sprites == rhs.sprites &&
        lhs.cries == rhs.cries &&
        lhs.stats == rhs.stats &&
        lhs.types == rhs.types &&
        lhs.pastTypes == rhs.pastTypes
    }
    
    var imageUrl: String? {
        return sprites?.versions?.generationV?.blackWhite?.frontDefault
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order
        case weight
        case abilities
        case forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves
        case species
        case sprites
        case cries
        case stats
        case types
        case pastTypes = "past_types"
    }
    
    init(
        id: Int? = nil,
        name: String? = nil,
        baseExperience: Int? = nil,
        height: Int? = nil,
        isDefault: Bool? = nil,
        order: Int? = nil,
        weight: Int? = nil,
        abilities: [AbilityEntry]? = nil,
        forms: [NamedAPIResource]? = nil,
        gameIndices: [GameIndex]? = nil,
        heldItems: [HeldItem]? = nil,
        locationAreaEncounters: String? = nil,
        moves: [MoveEntry]? = nil,
        species: NamedAPIResource? = nil,
        sprites: Sprites? = nil,
        cries: Cries? = nil,
        stats: [StatEntry]? = nil,
        types: [TypeEntry]? = nil,
        pastTypes: [PastType]? = nil
    ) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.height = height
        self.isDefault = isDefault
        self.order = order
        self.weight = weight
        self.abilities = abilities
        self.forms = forms
        self.gameIndices = gameIndices
        self.heldItems = heldItems
        self.locationAreaEncounters = locationAreaEncounters
        self.moves = moves
        self.species = species
        self.sprites = sprites
        self.cries = cries
        self.stats = stats
        self.types = types
        self.pastTypes = pastTypes
    }
}

extension PokemonDetail {
    static let previewPokemon = PokemonDetail(
        id: 25,
        name: "Pikachu",
        baseExperience: 112,
        height: 4,
        isDefault: true,
        order: 35,
        weight: 60,
        abilities: [AbilityEntry(isHidden: false, slot: 1, ability: NamedAPIResource(name: "static", url: ""))],
        forms: [NamedAPIResource(name: "pikachu", url: "")],
        gameIndices: [GameIndex(gameIndex: 1, version: NamedAPIResource(name: "red", url: ""))],
        heldItems: [],
        locationAreaEncounters: "",
        moves: [],
        species: NamedAPIResource(name: "pikachu", url: ""),
        sprites: Sprites.preview,
        cries: Cries(latest: "", legacy: ""),
        stats: [],
        types: [TypeEntry(slot: 1, type: NamedAPIResource(name: "electric", url: ""))],
        pastTypes: []
    )
}

struct AbilityEntry: Codable,Equatable {
    let isHidden: Bool?
    let slot: Int?
    let ability: NamedAPIResource?
    
    init(isHidden: Bool? = nil, slot: Int? = nil, ability: NamedAPIResource? = nil) {
        self.isHidden = isHidden
        self.slot = slot
        self.ability = ability
    }
}

extension AbilityEntry {
    static let preview = AbilityEntry(isHidden: true, slot: 1, ability: .preview)
}

struct GameIndex: Codable , Equatable{
    let gameIndex: Int?
    let version: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
    
    init(gameIndex: Int? = nil, version: NamedAPIResource? = nil) {
        self.gameIndex = gameIndex
        self.version = version
    }
}

extension GameIndex {
    static let preview = GameIndex(gameIndex: 1, version: .preview)
}

struct HeldItem: Codable, Equatable {
    let item: NamedAPIResource?
    let versionDetails: [VersionDetail]?
    
    init(item: NamedAPIResource? = nil, versionDetails: [VersionDetail]? = nil) {
        self.item = item
        self.versionDetails = versionDetails
    }
}

extension HeldItem {
    static let preview = HeldItem(item: .preview, versionDetails: [VersionDetail.preview])
}

struct VersionDetail: Codable, Equatable {
    let rarity: Int?
    let version: NamedAPIResource?
    
    init(rarity: Int? = nil, version: NamedAPIResource? = nil) {
        self.rarity = rarity
        self.version = version
    }
}

extension VersionDetail {
    static let preview = VersionDetail(rarity: 5, version: .preview)
}

struct MoveEntry: Codable, Equatable {
    let move: NamedAPIResource?
    let versionGroupDetails: [VersionGroupDetail]?
    
    init(move: NamedAPIResource? = nil, versionGroupDetails: [VersionGroupDetail]? = nil) {
        self.move = move
        self.versionGroupDetails = versionGroupDetails
    }
}


extension MoveEntry {
    static let preview = MoveEntry(move: .preview, versionGroupDetails: [])
}

struct VersionGroupDetail: Codable, Equatable {
    let levelLearnedAt: Int?
    let versionGroup: NamedAPIResource?
    let moveLearnMethod: NamedAPIResource?
}

struct Sprites: Codable, Equatable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: OtherSprites?
    let versions: VersionSprites?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case backFemale = "back_female"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case other
        case versions
    }
    
    init(
        backDefault: String? = nil,
        backFemale: String? = nil,
        backShiny: String? = nil,
        backShinyFemale: String? = nil,
        frontDefault: String? = nil,
        frontFemale: String? = nil,
        frontShiny: String? = nil,
        frontShinyFemale: String? = nil,
        other: OtherSprites? = nil,
        versions: VersionSprites? = nil
    ) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
    }
    
    static let preview = Sprites(
        backDefault: "https://example.com/back_default.png",
        backFemale: "https://example.com/back_female.png",
        backShiny: "https://example.com/back_shiny.png",
        backShinyFemale: "https://example.com/back_shiny_female.png",
        frontDefault: "https://example.com/front_default.png",
        frontFemale: "https://example.com/front_female.png",
        frontShiny: "https://example.com/front_shiny.png",
        frontShinyFemale: "https://example.com/front_shiny_female.png",
        other: OtherSprites.preview,
        versions: VersionSprites.preview
    )
}

struct OtherSprites: Codable,Equatable  {
    let dreamWorld: SpriteSet?
    let home: SpriteSet?
    let officialArtwork: OfficialArtwork?
    let showdown: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
        case showdown
    }
    init(dreamWorld: SpriteSet? = nil, home: SpriteSet? = nil, officialArtwork: OfficialArtwork? = nil, showdown: SpriteSet? = nil) {
        self.dreamWorld = dreamWorld
        self.home = home
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
    
    static let preview = OtherSprites(dreamWorld: .preview, home: .preview, officialArtwork: .preview, showdown: .preview)
}

struct SpriteSet: Codable, Equatable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backFemale = "back_female"
    }
    
    init(
        frontDefault: String? = nil,
        frontFemale: String? = nil,
        frontShiny: String? = nil,
        frontShinyFemale: String? = nil,
        backDefault: String? = nil,
        backFemale: String? = nil,
        backShiny: String? = nil,
        backShinyFemale: String? = nil
    ) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
    }
    
    static let preview = SpriteSet(
        frontDefault: "https://example.com/front_default.png",
        frontFemale: "https://example.com/front_female.png",
        frontShiny: "https://example.com/front_shiny.png",
        frontShinyFemale: "https://example.com/front_shiny_female.png",
        backDefault: "https://example.com/back_default.png",
        backFemale: "https://example.com/back_female.png",
        backShiny: "https://example.com/back_shiny.png",
        backShinyFemale: "https://example.com/back_shiny_female.png"
    )
}

struct OfficialArtwork: Codable, Equatable {
    let frontDefault: String?
    let frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    
    init(frontDefault: String? = nil, frontShiny: String? = nil) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
    
    static let preview = OfficialArtwork(frontDefault: "https://example.com/front.png", frontShiny: "https://example.com/shiny.png")
}

struct VersionSprites: Codable, Equatable {
    let generationI: GenerationI?
    let generationII: GenerationII?
    let generationIII: GenerationIII?
    let generationIV: GenerationIV?
    let generationV: GenerationV?
    let generationVI: [String: SpriteSet]?
    let generationVII: GenerationVII?
    let generationVIII: GenerationVIII?
    
    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationII = "generation-ii"
        case generationIII = "generation-iii"
        case generationIV = "generation-iv"
        case generationV = "generation-v"
        case generationVI = "generation-vi"
        case generationVII = "generation-vii"
        case generationVIII = "generation-viii"
    }
    
    init(
        generationI: GenerationI? = nil,
        generationII: GenerationII? = nil,
        generationIII: GenerationIII? = nil,
        generationIV: GenerationIV? = nil,
        generationV: GenerationV? = nil,
        generationVI: [String: SpriteSet]? = nil,
        generationVII: GenerationVII? = nil,
        generationVIII: GenerationVIII? = nil
    ) {
        self.generationI = generationI
        self.generationII = generationII
        self.generationIII = generationIII
        self.generationIV = generationIV
        self.generationV = generationV
        self.generationVI = generationVI
        self.generationVII = generationVII
        self.generationVIII = generationVIII
    }
    
    static let preview = VersionSprites(
        generationI: .preview,
        generationII: .preview,
        generationIII: .preview,
        generationIV: .preview,
        generationV: .preview,
        generationVI: ["x-y": .preview],
        generationVII: .preview,
        generationVIII: .preview
    )
}

struct GenerationI: Codable, Equatable {
    let redBlue: SpriteSet?
    let yellow: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
    
    init(redBlue: SpriteSet? = nil, yellow: SpriteSet? = nil) {
        self.redBlue = redBlue
        self.yellow = yellow
    }
    
    static let preview = GenerationI(redBlue: .preview, yellow: .preview)
    
}

struct GenerationII: Codable, Equatable {
    let crystal: SpriteSet?
    let gold: SpriteSet?
    let silver: SpriteSet?
    
    init(crystal: SpriteSet? = nil, gold: SpriteSet? = nil, silver: SpriteSet? = nil) {
        self.crystal = crystal
        self.gold = gold
        self.silver = silver
    }
    
    static let preview = GenerationII(crystal: .preview, gold: .preview, silver: .preview)
}

struct GenerationIII: Codable, Equatable {
    let emerald: OfficialArtwork?
    let fireredLeafgreen: SpriteSet?
    let rubySapphire: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
    
    
    init(emerald: OfficialArtwork? = nil, fireredLeafgreen: SpriteSet? = nil, rubySapphire: SpriteSet? = nil) {
        self.emerald = emerald
        self.fireredLeafgreen = fireredLeafgreen
        self.rubySapphire = rubySapphire
    }
    
    static let preview = GenerationIII(emerald: .preview, fireredLeafgreen: .preview, rubySapphire: .preview)
}

struct GenerationIV: Codable , Equatable{
    let diamondPearl: SpriteSet?
    let heartgoldSoulsilver: SpriteSet?
    let platinum: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
    
    init(diamondPearl: SpriteSet? = nil, heartgoldSoulsilver: SpriteSet? = nil, platinum: SpriteSet? = nil) {
        self.diamondPearl = diamondPearl
        self.heartgoldSoulsilver = heartgoldSoulsilver
        self.platinum = platinum
    }
    
    static let preview = GenerationIV(
        diamondPearl: .preview,
        heartgoldSoulsilver: .preview,
        platinum: .preview
    )
    
}

struct GenerationV: Codable, Equatable {
    
    let blackWhite: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
    
    init(blackWhite: SpriteSet? = nil) {
        self.blackWhite = blackWhite
    }
    
    static let preview = GenerationV(
        blackWhite: .preview
    )
}
struct GenerationVI: Codable, Equatable {
    let omegarubyAlphasapphire: SpriteSet?
    let xy:SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case omegarubyAlphasapphire = "omegaruby-alphasapphire"
        case xy = "x-y"
    }
    
    init(omegarubyAlphasapphire: SpriteSet? = nil, xy: SpriteSet? = nil) {
        self.omegarubyAlphasapphire = omegarubyAlphasapphire
        self.xy = xy
    }
    
    static let preview = GenerationVI(
        omegarubyAlphasapphire: .preview,
        xy: .preview
    )
}

struct AnimatedSprites: Codable, Equatable {
    let animated: SpriteSet?
    
    init(animated: SpriteSet? = nil) {
        self.animated = animated
    }
    
    static let preview = AnimatedSprites(
        animated: .preview
    )
}

struct GenerationVII: Codable,Equatable {
    let icons: SpriteSet?
    let ultraSunUltraMoon: SpriteSet?
    
    enum CodingKeys: String, CodingKey {
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
        case icons
    }
    
    init(icons: SpriteSet? = nil, ultraSunUltraMoon: SpriteSet? = nil) {
        self.icons = icons
        self.ultraSunUltraMoon = ultraSunUltraMoon
    }
    
    static let preview = GenerationVII(
        icons: .preview,
        ultraSunUltraMoon: .preview
    )
}

struct GenerationVIII: Codable,Equatable {
    let icons: SpriteSet?
    
    init(icons: SpriteSet? = nil) {
        self.icons = icons
    }
    
    static let preview = GenerationVIII(
        icons: .preview
    )
    
}

struct Cries: Codable, Equatable {
    let latest: String?
    let legacy: String?
    
    init(latest: String? = nil, legacy: String? = nil) {
        self.latest = latest
        self.legacy = legacy
    }
    
    static let preview = Cries(
        latest: "https://example.com/latest.mp3",
        legacy: "https://example.com/legacy.mp3"
    )
}

struct StatEntry: Codable, Equatable {
    let baseStat: Int?
    let effort: Int?
    let stat: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    init(baseStat: Int? = nil, effort: Int? = nil, stat: NamedAPIResource? = nil) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
    
    static let preview = StatEntry(
        baseStat: 100,
        effort: 2,
        stat: .preview
    )
}

struct TypeEntry: Codable, Equatable, Identifiable {
    var id = UUID()
    let slot: Int?
    let type: NamedAPIResource?
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slot = try container.decodeIfPresent(Int.self, forKey: .slot)
        self.type = try container.decodeIfPresent(NamedAPIResource.self, forKey: .type)
        self.id = UUID()
    }
    
    init(slot: Int?, type: NamedAPIResource?) {
        self.slot = slot
        self.type = type
        self.id = UUID() // Generar un UUID único
    }
}

struct PastType: Codable ,Equatable{
    let generation: NamedAPIResource?
    let types: [TypeEntry]?
}

struct NamedAPIResource: Codable, Equatable {
    let name: String?
    let url: String?
    
    init(name: String? = nil, url: String? = nil) {
        self.name = name
        self.url = url
    }
}

extension NamedAPIResource {
    static let preview = NamedAPIResource(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
}
