//
//  Pokemon.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//
import Foundation
import SwiftUI


//==============================

struct Pokemon: Codable{
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct PokemonDetails: Codable {
    let abilities: [ElementAbility]
    let base_experience: Int
    let height: Int
    let id: Int
    let sprites: Sprites
    let stats: [StatElement]
    let types: [TypeElement]
    let weight: Int
    let species: PokemonSpecies
//    let pokemonSpecies: PokemonSpecies
}

// Estructura para decodificar los detalles de la especie del Pokémon
struct PokemonSpeciesDetails: Codable {
    let flavorTextEntries: [FlavorTextEntry]

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
    }
}

struct PokemonSpecies: Codable {
    let name: String
    let url: String
}

struct StatElement: Codable{
    let base_stat: Int
    let stat: Stat
    let effort: Int
}

struct Stat: Codable{
    let name: String
    let url: String
   
}
// ABILITIES --------------------
struct ElementAbility: Codable {
    let slot: Int
    let is_hidden: Bool
    let ability: Ability
}

struct Ability: Codable {
    let name: String
    let url: String
}



struct TypeElement: Codable {
    let slot: Int
    let type: Type
}

struct Type: Codable {
    let name: String
    let url: String
}

// Images --------------------
struct Sprites: Codable {
    let frontDefault: String?
    let other: [String: FrontDefaultImage]
    
    enum CodingKeys: String, CodingKey {
        case other
        case frontDefault = "front_default"
    }
    // Agrega otros campos según tus necesidades, como back_default, back_shiny, etc.
}


struct FrontDefaultImage: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct OfficialArtwork: Codable {
    let front_default: String?
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork // Estructura que refleja el anidamiento de "official-artwork"
}
//==============================

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct PokemonResponse: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

