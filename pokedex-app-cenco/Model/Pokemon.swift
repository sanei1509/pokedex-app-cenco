//
//  Pokemon.swift
//  pokedex-app-cenco
//
//  Created by Santiago Neira on 6/11/23.
//




import Foundation
import SwiftUI


//struct Pokemon2: Decodable, Identifiable{
//    let id:Int
//    let name:String
//    let imageUrl:String
//    let type: String
//    let description:String
//    let height:Int
//    let weight:Int
//}


struct Pokemon: Codable{
    var count: Int
    var next: String
    var previous: String?
    var results: [PokemonEntry]
}


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

struct PokemonEntry: Codable, Identifiable {
    var id: Int?
    var name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Intenta decodificar el campo "id" si está presente en el JSON
        id = try? container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }
}

class PokeApi {
    //vamos a traer una colección de pokemones
    func getData(completion: @escaping ([PokemonEntry]) -> ()){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50") else {return}
            
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            // Crear una instancia de JSONDecoder
            let decoder = JSONDecoder()

            do {
                // Llamar al método 'decode' en la instancia de JSONDecoder
                let pokemonList = try decoder.decode(Pokemon.self, from: data)
                
                DispatchQueue.main.async {
                    completion(pokemonList.results)
                }
            } catch {
                // Maneja errores de decodificación aquí
                print("Error al decodificar JSON: \(error)")
            }
            
            

        }.resume()
    }
}
