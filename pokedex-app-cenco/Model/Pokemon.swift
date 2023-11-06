//
//  Pokemon.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//




import Foundation
import SwiftUI


struct Pokemon: Decodable, Identifiable{
    let id:Int
    let name:String
    let imageUrl:String
    let type: String
    let description:String
    let height:Int
    let weight:Int
}

let PokemonList:[Pokemon] = [
    .init(id: 1, name: "Ivysaur", imageUrl: "", type: "poison", description: "", height: 5, weight: 5),
    .init(id: 2, name: "Pikachu", imageUrl: "", type: "electric", description: "", height: 3, weight: 10),
    .init(id: 3, name: "Squirtle", imageUrl: "", type: "water", description: "", height: 5, weight: 5),
    .init(id: 4, name: "Charmander", imageUrl: "", type: "fire", description: "", height: 10, weight: 15),
    .init(id: 5, name: "Ivysaur", imageUrl: "", type: "psychic", description: "", height: 5, weight: 5),
    .init(id: 6, name: "Pikachu", imageUrl: "", type: "fairy", description: "", height: 3, weight: 10),
    .init(id: 7, name: "Squirtle", imageUrl: "", type: "normal", description: "", height: 5, weight: 5),
    .init(id: 8, name: "Charmander", imageUrl: "", type: "flying", description: "", height: 10, weight: 15)
]


func backgroundColor(forType type:String)-> UIColor{
    switch type{
    case "fire": return .systemRed
    case "poison": return .systemGreen
    case "water": return .systemBlue
    case "electric": return .systemYellow
    case "psychic": return .systemPurple
    case "ground": return .systemGray
    case "normal": return .systemOrange
    case "flying": return .systemBrown
    case "fairy": return .systemPink
    default : return .systemIndigo
    }
}
