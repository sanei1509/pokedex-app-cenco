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

//struct Pokemon: Codable {
//    var name: String
//    var url: String
//    var id: Int? {
//        return Int(url.split(separator: "/").last?.description ?? "0")
//    }
//    
//    var imageUrl: URL? {
//        if let id = self.id {
//            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
//        }
//        return nil
//    }
//    
//}


//let PokemonList:[Pokemon2] = [
//    .init(id: 1, name: "Ivysaur", imageUrl: "", type: "poison", description: "", height: 5, weight: 5),
//    .init(id: 2, name: "Pikachu", imageUrl: "", type: "electric", description: "", height: 3, weight: 10),
//    .init(id: 3, name: "Squirtle", imageUrl: "", type: "water", description: "", height: 5, weight: 5),
//    .init(id: 4, name: "Charmander", imageUrl: "", type: "fire", description: "", height: 10, weight: 15),
//    .init(id: 5, name: "Ivysaur", imageUrl: "", type: "psychic", description: "", height: 5, weight: 5),
//    .init(id: 6, name: "Pikachu", imageUrl: "", type: "fairy", description: "", height: 3, weight: 10),
//    .init(id: 7, name: "Squirtle", imageUrl: "", type: "normal", description: "", height: 5, weight: 5),
//    .init(id: 8, name: "Charmander", imageUrl: "", type: "flying", description: "", height: 10, weight: 15)
//]

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


struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

struct Pokemon: Codable{
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    let name: String
    let url: String
//    let types: [String]
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}


//struct TypeElement: Codable {
//    let type: String
//}


struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
}

