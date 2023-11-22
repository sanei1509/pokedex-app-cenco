//
//  Pokemon.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//
import Foundation
import SwiftUI


//==============================

struct PokemonDetails: Codable {
    let types: [TypeElement]
    let sprites: Sprites
}

struct PokemonDetails2: Codable {
    // # numero de pokemon
    let id: Int
    let types: [TypeElement]
    let sprites: Sprites
    let abilities: [Ability]
    //Size
    let height: Int
    let weight: Int
    //Stats
    let baseExperience: Int
    let stats: [StatItem]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case types = "types"
        case sprites = "sprites"
        case abilities = "abilities"
        case height = "height"
        case weight = "weight"
        case baseExperience = "base_experience"
        case stats = "stats"
    }
}

struct StatItem: Codable{
    let base_stat: StatDetail
}

struct StatDetail: Codable{
    let name: String
    let url: String
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

// Codigo para poder poner colores hexadecimales
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

func backgroundColor(forType type:String)-> Color{
    switch type{
    case "fire": return Color(hex:"#F7786A")
    case "poison": return Color(hex:"#ad6dc6")
    case "water": return Color(hex:"#58abf6")
    case "electric": return Color(hex:"#fece4a")
    case "psychic": return Color(hex:"#d660a7")
    case "ground": return Color(hex:"#CA8079")
    case "normal": return Color(hex:"#b6aac4")
    case "flying": return Color(hex:"#94B2C7")
    case "fairy": return Color(hex:"#edafdd")
    case "bug": return Color(hex:"#73a07d")
    case "grass": return Color(hex:"#61E3C3")
    default : return Color(hex:"#aaaaaa")
    }
}

struct Pokemon: Codable{
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    let name: String
    let url: String
    //pruebas ////

//    let types: [String]
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

